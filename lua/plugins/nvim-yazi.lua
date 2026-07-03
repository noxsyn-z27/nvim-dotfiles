-- yazi.nvim: ターミナルファイルマネージャー yazi を Neovim 内で起動するプラグイン。
-- 事前に yazi のインストールが必要 (cargo install yazi-fm yazi-cli)。
-- カスタマイズ:
--   - `<leader>-`: 現在ファイルの場所でyaziを開く (Normal / Visual モード)。開く前に未保存なら自動保存し E37 を回避。
--   - open_for_directories=false: ディレクトリを引数にした場合はyaziを自動起動しない。
--   - ヘルプキーを `<F1>` に設定。
--   - netrwを無効化してyaziに置き換え。
return {
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = { { "nvim-lua/plenary.nvim", lazy = true } },
  keys = {
    { 
      "<leader>-", 
      mode = { "n", "v" }, 
      function()
        -- yaziで同じファイルを選び直すと :edit が reload になり、
        -- 未保存の変更があると E37 になるため、開く前に保存しておく。
        if vim.bo.modified and vim.bo.modifiable and vim.api.nvim_buf_get_name ~= "" then
          vim.cmd("silent! write")
        end
      end, 
      desc = "Open yazi at the current file" }
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
