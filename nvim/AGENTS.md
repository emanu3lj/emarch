# AGENTS instructions for this repository
Scope: applies to all files under `/home/ema/.config/nvim`.
Purpose: guide agentic coders working on this Neovim config.
Keep edits minimal and scoped to the task.

## Repo summary
This is a personal Neovim configuration using `lazy.nvim` for plugins.
Lua source lives under `lua/`, with plugin specs in `lua/plugin/`.
Editor options and keymaps are set in `init.lua`.
Autocommands live in `lua/config/audocmd.lua`.
Plugin lockfile is `lazy-lock.json`; avoid manual edits.
There are no tests or build artifacts in the repo.

## Tooling and workflows
Use Neovim 0.9+ (LuaJIT) when running the config.
Plugin manager: [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim).
Install plugins by opening Neovim; lazy will sync automatically.
Update plugins from inside Neovim with `:Lazy update`.
Sync Mason packages with `:MasonUpdate` when LSP/formatter changes.
Treesitter parsers update via `:TSUpdate` (invoked automatically on install).
Color scheme uses `kanagawa.nvim` with `theme = "wave"`.
Completion uses `saghen/blink.cmp` with LSP, path, and buffer sources.
LSP uses `nvim-lspconfig`, Mason, and Mason-LSPConfig.
Formatting on save is enabled when the server supports it.
Diagnostics are configured globally; respect virtual text and signs.

## Build / lint / test commands
There is no traditional build step; configuration is loaded by Neovim.
To validate the Lua syntax quickly: `luacheck lua` (if available).
Default formatter: `stylua` (ensured via Mason).
Format all Lua files: `stylua lua init.lua`.
Format a single file: `stylua lua/plugin/lsp.lua`.
No automated linting is configured; prefer `stylua` for consistency.
No automated tests exist; there is no single-test runner.
If you must sanity check the config, run: `nvim --headless "+q"`.
To check plugin health headlessly: `nvim --headless "+Lazy! sync" +qa`.
Treesitter debug: `nvim --headless "+TSInstallInfo" +qa`.
Avoid adding heavy CI commands unless requested.

## Dependencies and versions
Neovim 0.9+ (LuaJIT runtime).
Lua language server `lua_ls` is expected via Mason.
`stylua` formatter expected via Mason for Lua formatting.
Treesitter parsers listed in `lua/plugin/treesitter.lua` should remain installed.
Plugin specs live in `lua/plugin/*.lua`; keep them declarative.

## Coding style (general)
Follow idiomatic Lua style used across the config.
Prefer two-space indentation; avoid tabs in Lua files.
Use double quotes for strings unless single quotes aid readability.
Keep lines reasonably short (< 100 chars) for readability.
Return tables directly from plugin spec files.
Avoid trailing whitespace and unnecessary blank lines.
Avoid inline comments unless clarifying non-obvious decisions.
Group related keymaps and options logically.
Avoid global variables; prefer local where possible.

## Imports and module usage
Use `require` with module paths under `lua/` (e.g., `require("plugin.lsp")`).
Cache required modules locally when used multiple times in a function.
Do not mutate modules returned by `require` unless they are plugin APIs.
Prefer explicit module paths over relative `dofile`.

## Naming conventions
Use snake_case for local variables and fields.
Use PascalCase for module-like tables if exposed globally.
Keymaps and autogroups should have descriptive names (e.g., `kickstart-highlight-yank`).
Plugin specifications should be short and descriptive.

## Error handling
Check for server capabilities (e.g., formatting) before invoking LSP actions.
Fail early and loudly when bootstrap steps (like cloning lazy.nvim) fail.
Prefer `vim.notify` or `vim.api.nvim_echo` for user-facing errors.
Avoid swallowing errors silently; log context in callbacks when debugging.

## Formatting conventions
Use `stylua` defaults; prefer keeping `column_width` default unless changed.
Keep trailing commas in tables that span multiple lines.
Align closing braces with the opening statement.
Place one plugin spec per table entry in return list.
Use parentheses for multi-argument function calls from keymaps.

## Plugin-specific notes
`lua/plugin/blink.lua`: completion sources are LSP, path, buffer; keep docs enabled.
`lua/plugin/color.lua`: kanagawa is loaded eagerly with priority 1000.
`lua/plugin/lsp.lua`: shared `on_attach` sets format-on-save; respect capability checks.
`lua/plugin/telescope.lua`: simple spec; add extensions inside the returned table.
`lua/plugin/treesitter.lua`: `ensure_installed` includes many languages; keep `additional_vim_regex_highlighting = true` unless intentionally changed.
`lua/plugin/which-key.lua`: minimal config; describe new mappings for discoverability.
`lua/config/audocmd.lua`: yank highlight autocmd lives here; add new autocmds with clear group names.
`init.lua`: bootstraps lazy.nvim; avoid altering the bootstrap unless necessary.

## Keymap guidance
Leader is space; localleader is backslash.
Document new mappings with `desc` for which-key compatibility.
Avoid overriding common defaults without strong justification.

## File organization
Place new plugin specs in `lua/plugin/` as separate files when possible.
Place shared configuration helpers in `lua/config/`.
Keep `init.lua` concise; delegate to modules.
Avoid editing `lazy-lock.json` manually; let lazy.nvim manage it.



## Testing and validation guidance
There is no automated test suite.
Manually verify changes by opening Neovim with this config.
For plugin changes, smoke test key flows (completion, LSP formatting, Treesitter highlights).
Document manual test steps in PR descriptions when applicable.

## Git and review etiquette
Do not create commits unless the user explicitly requests.
Keep diffs minimal and scoped to the requested change.
Avoid rearranging unrelated settings.
Describe rationale in PR summaries or user updates.

## Cursor/Copilot rules
No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md` are present.
If such rules appear later, incorporate them into this document.

## Security and safety
Do not embed secrets or tokens in config.
Be cautious with plugins that execute remote code.
Avoid setting shell aliases or commands that could be destructive.

## When adding new plugins
Check for Lazy-compatible specs; include `dependencies` explicitly.
Set `lazy = false` only when necessary for startup behavior.
Use `event`, `ft`, or `cmd` keys to defer loading when appropriate.
Document configuration options inside the plugin spec.

## LSP configuration tips
Reuse the shared `on_attach` callback for buffer-local behavior.
Set `capabilities` when integrating with completion plugins if needed.
Keep diagnostic configuration centralized to avoid duplication.

## Treesitter guidance
Update `ensure_installed` carefully; keep it alphabetized where possible.
Enable or disable `additional_vim_regex_highlighting` deliberately.
Use `build = ":TSUpdate"` for parser updates.

## Formatting on save
Formatting is conditional on server capabilities; do not force formatters that are absent.
Prefer server-provided formatting; fall back to formatter plugins only when required.

## Quick checklist before finishing a change
[ ] Plugins load via lazy without errors.
[ ] stylua formatting applied to touched Lua files.
[ ] Keymaps include `desc` and respect leader/localleader.
[ ] No manual edits to `lazy-lock.json`.
[ ] Manual smoke test of affected feature if feasible.
[ ] Documented any manual steps required for users.

