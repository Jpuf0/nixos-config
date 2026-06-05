local blink = require("blink.cmp")

blink.setup({
  keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" }, ["<Tab>"] = { "accept", "fallback" } },

  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- Will be removed in a future release
    use_nvim_cmp_as_default = true,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
})

-- local blink_opts = {
-- 	servers = {
-- 		bashls = {},
-- 		-- ccls = {},
-- 		cmake = {},
-- 		-- cssls = {},
-- 		html = {},
-- 		omnisharp = {},
-- 		rust_analyzer = {},
-- 		sqlls = {},
-- 		ts_ls = {},
-- 	},
-- }
--
-- local lspconfig = require("lspconfig")
-- for server,config in pairs(blink_opts.servers) do
-- 	-- passing config.capabilities to blink.cmp merges with the capabilities in your
-- 	-- `opts[server].capabilities, if you've defined it
-- 	config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
-- 	lspconfig[server].setup(config)
-- end
