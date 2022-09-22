local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace();

lsp.setup();


-- CMP custom config
local cmpConfig = require('user.cmp')

local mergedConfig = lsp.defaults.cmp_config(cmpConfig)

local cmp = require 'cmp'
cmp.setup(mergedConfig)
