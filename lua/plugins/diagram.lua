-- diagram.nvim: Markdown内のコードブロック (```mermaid など) を画像化してインライン表示するプラグイン。
-- image.nvim を描画バックエンドとして利用する。
-- 前提:
--   - Mermaid のレンダリングには mermaid-cli (`mmdc`) が必要:
--       npm install -g @mermaid-js/mermaid-cli
-- カスタマイズ:
--   - integrations: markdown のコードブロックを対象にする。
--   - renderer_options.mermaid.theme: 図の配色テーマ ( forest / dark / neutral 等から選択可)
--   - events: BufWinEnter とノーマルモード復帰時に再描画。
return {
  "3rd/diagram.nvim",
  dependencies = { "3rd/image.nvim" },
  ft = { "markdown" },
  opts = function()
    return {
      integrations = {
        require("diagram.integrations.markdown"),
      },
      renderer_options = {
        mermaid = {
          theme = "dark",
          background = "transparent",
          scale = 2,
          -- Ubuntu の AppArmor サンドボックス制限で Chromium が起動できないため
          cli_args = { "-p", vim.fn.stdpath("config") .. "/puppeteer-config.json" },
        },
      },
      events = {
        render_buffer = { "BufWinEnter", "TextChanged", "InsertLeave" },
        clear_buffer = { "BufLeave" }
      }
    }
  end,
}