if vim.env.GEMINI_API_KEY then
  local gemini_api_key = vim.env.GEMINI_API_KEY

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*/COMMIT_EDITMSG" },
    callback = function(ev)
      vim.api.nvim_buf_create_user_command(ev.buf, "InjectCommitMsg", function()
        local Job = require("plenary.job")
        local diff = ""
        Job:new({
          command = 'git',
          args = { 'diff', '--cached' },
          on_stdout = function(_, data)
            diff = diff .. data
          end,
        }):sync()

        local body = vim.json.encode(
          {
            contents = {
              {
                parts = {
                  {
                    text = "Write commit message in one line for following changes." .. "\n" .. diff
                  }
                }
              }
            },
          }
        )

        local curl = require("plenary.curl")
        local res = curl.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=" .. gemini_api_key,
          {
            headers = {
              ["Content-Type"] = "application/json",
            },
            body = body,
          }
        )

        local response = vim.json.decode(res.body).candidates[1].content.parts[1].text
        vim.api.nvim_buf_set_lines(ev.buf, 0, 0, true, { response })
      end, {})
    end,
  })
end
