let
  nord = import ../../../const/nord.nix;
in
{
  enable = true;
  defaultEditor = true;

  settings = {
    theme = "nord";

    editor = {
      file-picker = {
        hidden = false;
      };
    };

    keys = {
      normal = {
        C-q = ":q";
      };
      insert = {
        "," = {
          d = "normal_mode";
        };
      };
    };
  };

  themes = {
    nord = {
      "constant" = nord.nord4;
      "constant.builtin" = nord.nord9;
      "constant.builtin.boolean" = nord.nord9;
      "constant.builtin.character" = nord.nord15;
      "constant.character.escape" = nord.nord13;
      "constant.macro" = nord.nord9;
      "constant.numeric" = nord.nord15;
      "constructor" = nord.nord8;

      "diagnostic" = { underline = { color = nord.nord13; style = "curl"; }; };
      "diagnostic.error" = { underline = { color = nord.nord11; style = "curl"; }; };
      "error" = nord.nord11;
      "diagnostic.hint" = { underline = { color = nord.nord10; style = "curl"; }; };
      "hint" = nord.nord10;
      "diagnostic.info" = { underline = { color = nord.nord8; style = "curl"; }; };
      "info" = nord.nord8;
      "diagnostic.warning" = { underline = { color = nord.nord13; style = "curl"; }; };
      "warning" = nord.nord13;

      "diff.delta" = nord.nord13;
      "diff.minus" = nord.nord11;
      "diff.plus" = nord.nord14;

      "function" = nord.nord8;
      "function.builtin" = nord.nord7;
      "function.method" = nord.nord8;
      "function.macro" = nord.nord9;
      "function.special" = nord.nord9;

      "git.delta.moved" = nord.nord12;

      "keyword" = nord.nord9;
      "keyword.control.conditional" = nord.nord9;
      "keyword.control.exception" = nord.nord9;
      "keyword.control.repeat" = nord.nord9;
      "keyword.directive" = nord.nord9;
      "keyword.function" = nord.nord9;
      "keyword.operator" = nord.nord9;
      "keyword.return" = nord.nord9;
      "keyword.storage.modifier" = nord.nord9;
      "keyword.storage.type" = nord.nord9;

      "punctuation" = nord.nord6;
      "punctuation.bracket" = nord.nord6;
      "punctuation.delimiter" = nord.nord6;
      "punctuation.special" = nord.nord9;

      "string" = nord.nord14;
      "string.escape" = nord.nord13;
      "string.regex" = nord.nord13;
      "string.special" = nord.nord13;

      "type" = nord.nord7;
      "type.builtin" = nord.nord7;

      "variable" = nord.nord4;
      "variable.builtin" = nord.nord9;
      "variable.other.member" = nord.nord4;
      "variable.parameter" = nord.nord8;
      "attribute" = nord.nord9;

      "label" = nord.nord7;
      "namespace" = nord.nord4;
      "operator" = nord.nord9;
      "special" = nord.nord9;
      "tag" = nord.nord7;
      "comment" = { fg = nord.nord3_bright; modifiers = [ "italic" ]; };

      "ui.background" = { bg = nord.nord0; };
      "ui.text" = nord.nord4;
      "ui.window" = nord.nord1;

      "ui.debug.active" = nord.nord13;
      "ui.debug.breakpoint" = nord.nord11;

      "ui.menu" = { bg = nord.nord1; };
      "ui.menu.scroll" = { fg = nord.nord4; bg = nord.nord3; };
      "ui.menu.selected" = { fg = nord.nord8; bg = nord.nord2; };
      "ui.popup" = { bg = nord.nord1; };
      "ui.popup.info" = { bg = nord.nord1; };
      "ui.help" = { bg = nord.nord1; };
      "ui.text.focus" = { fg = nord.nord8; bg = nord.nord2; };

      "ui.gutter" = nord.nord5;
      "ui.linenr" = nord.nord3;
      "ui.linenr.selected" = nord.nord5;

      "ui.cursor" = { fg = nord.nord4; modifiers = [ "reversed" ]; };
      "ui.cursorcolumn.primary" = { bg = nord.nord1; };
      "ui.cursorline.primary" = { bg = nord.nord1; };

      "ui.selection" = { bg = nord.nord2; };
      "ui.highlight" = { fg = nord.nord8; bg = nord.nord2; };

      "ui.statusline" = { bg = nord.nord1; };
      "ui.statusline.inactive" = { fg = nord.nord8; bg = nord.nord1; };
      "ui.statusline.insert" = { fg = nord.nord1; bg = nord.nord6; };
      "ui.statusline.normal" = { fg = nord.nord1; bg = nord.nord8; };
      "ui.statusline.select" = { fg = nord.nord1; bg = nord.nord7; };
      "ui.statusline.separator" = nord.nord3;

      "ui.virtual.indent-guide" = nord.nord3;
      "ui.virtual.inlay-hint" = { fg = nord.nord3; modifiers = [ "italic" ]; };
      "ui.virtual.ruler" = { bg = nord.nord1; };
      "ui.virtual.whitespace" = nord.nord3;
      "ui.virtual.wrap" = nord.nord3;

      "ui.bufferline" = { fg = nord.nord5; bg = nord.nord1; };
      "ui.bufferline.active" = { fg = nord.nord6; bg = nord.nord2; underline = { color = nord.nord8; style = "line"; }; modifiers = [ "italic" ]; };

      "markup.heading" = nord.nord8;
      "markup.list" = nord.nord9;
      "markup.bold" = { modifiers = [ "bold" ]; };
      "markup.italic" = { modifiers = [ "italic" ]; };
      "markup.strikethrough" = { modifiers = [ "crossed_out" ]; };
      "markup.link.text" = nord.nord8;
      "markup.raw" = nord.nord7;
    };
  };
}
