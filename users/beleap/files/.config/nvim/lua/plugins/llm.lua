return {
  {
    'gsuuon/model.nvim',
    cmd = { 'M', 'Model', 'Mchat' },
    init = function()
      vim.filetype.add({
        extension = {
          mchat = 'mchat',
        }
      })
    end,
    ft = 'mchat',
    keys = {
      { '<C-m>d',       ':Mdelete<cr>', mode = 'n' },
      { '<C-m>s',       ':Mselect<cr>', mode = 'n' },
      { '<C-m><space>', ':Mchat<cr>',   mode = 'n' }
    },
    config = function()
      local gemini = {
        request_completion = function(handlers, params, options)
          local util = require('model.util')
          local juice = require('model.util.juice')
          local curl = require('model.util.curl')

          local key = util.env_memo('PALM_API_KEY')

          local remove_marquee = juice.handler_marquee_or_notify(
            'Gemini Pro ',
            handlers.segment
          )

          local function handle_finish(raw_data)
            local response = util.json.decode(raw_data)

            if response == nil then
              error('Failed to decode json response:\n' .. raw_data)
            end

            if response.error ~= nil or not response.candidates then
              handlers.on_error(response)
              remove_marquee()
            else
              local first_candidate = response.candidates[1]

              if first_candidate == nil then
                error('No candidate returned:\n' .. raw_data)
              end

              local result = first_candidate.content.parts[1].text

              handlers.on_finish(result, 'stop')
              remove_marquee()
            end
          end
          local function handle_error()
            handlers.on_error()
          end

          return curl.request({
            headers = {
              ["Content-Type"] = "application/json",
            },
            method = "POST",
            url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=" .. key,
            body = params,
          }, handle_finish, handle_error)
        end
      }

      require('model').setup(
        {
          prompts = {
            gemini = {
              provider = gemini,
              builder = function(input)
                return {
                  contents = {
                    {
                      parts = {
                        {
                          text = input
                        }
                      }
                    }
                  }
                }
              end
            },
            commit = {
              provider = gemini,
              mode = require('model').mode.INSERT,
              builder = function()
                local git_diff = vim.fn.system { 'git', 'diff', '--staged' }

                if not git_diff:match('^diff') then
                  error('Git error:\n' .. git_diff)
                end

                return {
                  contents = {
                    {
                      parts = {
                        {
                          text =
                              'Write a terse commit message according to the Conventional Commits specification. Try to stay below 80 characters total. Staged git diff: ```\n' ..
                              git_diff .. '\n```'
                        }
                      }
                    }
                  }
                }
              end,
            },
          },
        })
    end
  },
}
