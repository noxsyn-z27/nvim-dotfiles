-- image.nvim: ターミナル上に画像をインライン描画するプラグイン。Mermaid図の表示基盤となる。
-- 前提: 
--   - ターミナルが Kitty graphics protocol 対応であること (Ghostty / Kitty / WezTerm 等)
--     Ghosttyを使用するため backend = "kitty" を仕様。
--   - ImageMagick の CLI (`magick`)が必要。processor = "magick_cli" で luarocks 不要にしている。
-- カスタマイズ:
--   - integrations: markdown のみ有効化し、diagram.nvim が生成した画像を描画させる。
--   - only_render_image_at_cursor=false: カーソル位置に関係なく画像を常時描画。
return {
  "3rd/image.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    backend = "kitty",
    processor = "magick_cli",
    integrations = {
        markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = false,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
        },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    -- 図全体を1画面に収める高さ上限。ウィンドウ高を超えると縦スクロール時に
    -- 下のテキストと重なって描画が崩れるため、90%に抑えて崩れを回避する。
    -- 細部を拡大したい場合はターミナル(Ghostty)のフォント拡大 Cmd + を使う。
    max_height_window_percentage = 90,
    window_overlap_clear_enabled = true,
    editor_only_render_when_focused = false,
  },
}