# Aidrun

A Neovim plugin that integrates with the aider chat tool.

## ✨ Features

-   Integrates aider chat tool directly into Neovim.
-   Provides commands for various aider actions such as `send`, `toggle`, `rewrite`, `ask`, `send_selection`, `file_picker`, and `inline`.
-   Configurable window size and behavior.
-   Supports various aider options.

## 📦 Installation

Install the plugin using lazy.nvim:

```lua
{
  "ezechukwu69/aidrun",
  -- Add any configuration here
    config = function()
        require("aidrun").setup({})
    end
}
```

## 🚀 Usage

Use the `:Aidrun` command followed by a subcommand:

-   `:Aidrun send`: Send the current buffer to aider.
-   `:Aidrun toggle`: Toggle the aider window.
-   `:Aidrun rewrite`: Rewrite the current buffer with aider.
-   `:Aidrun ask`: Ask a question to aider.
-   `:Aidrun send_selection`: Send the current selection to aider.
-   `:Aidrun file_picker`: Open the aider file picker.
-   `:Aidrun inline`: Use aider inline.

## ⚙️ Configuration

The plugin is configured via the `lua/config.lua` file.

### Options

-   `width`: The width of the aider window as a fraction of the screen width (default: 0.35).
-   `height`: The height of the aider window as a fraction of the screen height (default: 0.35).
-   `options`: A table containing the following options:
    -   `watch`: Whether to watch for file changes (default: true).
    -   `architect`: Whether to use the architect mode (default: true).
    -   `weak_model`: The weak model to use (default: "").
    -   `model`: The model to use (default: "").
    -   `editor_model`: The editor model to use (default: "").
    -   `editor_edit_format`: The editor edit format to use (default: "").
    -   `show_model_warnings`: Whether to show model warnings (default: true).
    -   `dark_mode`: Whether to use dark mode (default: true).
    -   `show_diffs`: Whether to show diffs (default: true).
    -   `edit_format`: The edit format to use (default: nil). Can be "whole", "diff", "diff-fenced", or "udiff".
    -   `auto_commits_disabled`: Whether to disable auto commits (default: true).
    -   `attribute_author_disabled`: Whether to disable author attribution (default: true).
    -   `attribute_committer_disabled`: Whether to disable committer attribution (default: true).
    -   `attribute_commit_message_author_disabled`: Whether to disable author attribution in commit messages (default: true).
    -   `attribute_commit_message_committer_disabled`: Whether to disable committer attribution in commit messages (default: true).
