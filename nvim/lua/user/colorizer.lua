require("colorizer").setup({
	"css",
	"javascript",
	"html",
	"vue",
}, {
	mode = "background",
	RRGGBBAA = false, -- #RRGGBBAA hex codes
	rgb_fn = false, -- CSS rgb() and rgba() functions
	hsl_fn = false, -- CSS hsl() and hsla() functions
	css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
})
