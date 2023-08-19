-- 
-- Plugin: "cocopon/iceberg.vim"
--

-- iceberg colorscheme:
-- let g:terminal_color_0 = '#1e2132
-- let g:terminal_color_1 = '#e27878
-- let g:terminal_color_2 = '#b4be82
-- let g:terminal_color_3 = '#e2a478
-- let g:terminal_color_4 = '#84a0c6
-- let g:terminal_color_5 = '#a093c7
-- let g:terminal_color_6 = '#89b8c2
-- let g:terminal_color_7 = '#c6c8d1
-- let g:terminal_color_8 = '#6b7089
-- let g:terminal_color_9 = '#e98989
-- let g:terminal_color_10 = '#c0ca8e
-- let g:terminal_color_11 = '#e9b189
-- let g:terminal_color_12 = '#91acd1
-- let g:terminal_color_13 = '#ada0d3
-- let g:terminal_color_14 = '#95c4ce
-- let g:terminal_color_15 = '#d2d4de

local colorscheme = "iceberg"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
