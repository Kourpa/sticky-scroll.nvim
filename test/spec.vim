set rtp^=../

" configuring the plugin
runtime plugin/sticky-scroll.lua
lua require('sticky-scroll').setup({ name = 'Jane Doe' })
