--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

-- ###
-- ### HSL operations
-- ###
--
-- Lush.hsl (and hsluv) provides a number of convenience functions for:
--
--   Relative adjustment (rotate(), saturate(), desaturate(), lighten(), darken())
--   Absolute adjustment (prefix above with abs_)
--   Combination         (mix())
--   Overrides           (hue(), saturation(), lightness())
--   Access              (.h, .s, .l)
--   Coercion            (tostring(), "Concatination: " .. color)
--   Helpers             (readable())
--
--   Adjustment functions have shortcut aliases, ro, sa, de, li, da
--                                               abs_sa, abs_de, abs_li, abs_da
--
-- Because HSL colors are represented by degrees around a colorwheel, we can find
-- harmonious colors from our original set by rotating the hue:
-- local sea_foam_triadic = sea_foam.rotate(120)
-- And we can also chain these operations:
-- local sea_foam_complement = sea_foam.rotate(180).darken(10).saturate(10)

local lush = require("lush")
local hsl = lush.hsl

local base = hsl(0, 0, 6)
local base_light = base.lighten(10)
local core = hsl(0, 3, 70)
local core_light = core.rotate(5).lighten(10)
local core_med = core.darken(20)
local core_dark = core.darken(40)
local core_darker = core.darken(60)
local core_darkest = core.darken(70)
-- guifg=#555555

local gray = hsl(0, 0, 40)
local gray_dark = gray.rotate(10).darken(10)
-- local gray = hsl(0, 0, 30)

local green = hsl(150, 98, 55)
local hazy = green.darken(90)
local green_alt = green.rotate(10).darken(80)

-- local brown

local flash = hsl(60, 90, 80)
local sunset = flash.darken(60)
local fire = flash.rotate(-120).darken(40)

local red = hsl(355, 65, 65)
local redBG = red.darken(90)
local orange = hsl(23, 100, 60)
local orangeBG = orange.darken(90)
-- local info = hsl(286, 66, 65)
-- local infoBG = info.darken(90)
-- local hint = hsl(181, 78, 53)
-- local hintBG = hint.darken(90)

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
    local sym = injected_functions.sym
    return {
        -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
        -- groups, mostly used for styling UI elements.
        -- Comment them out and add your own properties to override the defaults.
        -- An empty definition `{}` will clear all styling, leaving elements looking
        -- See :h highlight-groups
        --
        -- ColorColumn    { }, -- Columns set with 'colorcolumn'
        -- Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
        -- Cursor         { }, -- Character under the cursor
        CurSearch({ fg = green, bg = hazy }), -- Highlighting a search pattern under the cursor (see 'hlsearch')
        -- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
        -- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
        -- CursorColumn   { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine({ bg = base }), -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
        -- Directory      { }, -- Directory names (and other special names in listings)
        DiffAdd({ fg = green }), -- Diff mode: Added line |diff.txt|
        DiffChange({ fg = sunset }), -- Diff mode: Changed line |diff.txt|
        -- DiffDelete     { }, -- Diff mode: Deleted line |diff.txt|
        DiffText({ fg = sunset }), -- Diff mode: Changed text within a changed line |diff.txt|
        Changed({ fg = flash }),
        Added({ fg = green }),
        Removed({ fg = red }),
        -- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
        -- TermCursor     { }, -- Cursor in a focused terminal
        -- TermCursorNC   { }, -- Cursor in an unfocused terminal
        -- ErrorMsg       { }, -- Error messages on the command line
        -- VertSplit      { }, -- Column separating vertically split windows
        Folded({ fg = gray }), -- Line used for closed folds

        -- FoldColumn     { }, -- 'foldcolumn'
        -- SignColumn     { }, -- Column where |signs| are displayed
        IncSearch({ fg = green, bg = hazy }), -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        -- Substitute     { }, -- |:substitute| replacement text highlighting
        -- LineNr         { }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        -- LineNrAbove    { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
        -- LineNrBelow    { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
        -- CursorLineNr   { }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        -- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
        -- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
        -- MatchParen     { }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        -- ModeMsg        { }, -- 'showmode' message (e.g., "-- INSERT -- ")
        -- MsgArea        { }, -- Area for messages and cmdline
        -- MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        -- MoreMsg        { }, -- |more-prompt|
        -- NonText        { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal({ fg = core, bg = base }), -- Normal text
        -- NormalFloat({ bg = orangeBG }), -- Normal text in floating windows.
        FloatBorder({ fg = gray }), -- Border of floating windows.
        -- FloatTitle     { }, -- Title of floating windows.
        -- NormalNC({ bg = base_light, blend = 100 }), -- normal text in non-current windows
        Pmenu({ bg = base }), -- Popup menu: Normal item.
        PmenuSel({ fg = green, bg = hazy }), -- Popup menu: Selected item.
        -- PmenuKind      { }, -- Popup menu: Normal item "kind"
        -- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
        -- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
        -- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
        -- PmenuSbar      { }, -- Popup menu: Scrollbar.
        -- PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
        -- Question       { }, -- |hit-enter| prompt and yes/no questions
        -- QuickFixLine   { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search({ fg = green }), -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        -- SpecialKey     { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        -- SpellBad       { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        -- SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        -- SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        -- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        StatusLine({ bg = base_light }), -- Status line of current window
        StatusLineNC({ bg = base_light }), -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine({ fg = green, gui = "bold" }), -- Tab pages line, not active tab page label
        -- TabLineFill    { }, -- Tab pages line, where there are no labels
        -- TabLineSel     { }, -- Tab pages line, active tab page label
        -- Title          { }, -- Titles for output from ":set all", ":autocmd" etc.
        Visual({ fg = green, bg = hazy }), -- Visual mode selection
        -- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
        -- WarningMsg     { }, -- Warning messages
        -- Whitespace     { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        -- Winseparator({ fg = core_dark }), -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
        -- WildMenu       { }, -- Current match in 'wildmenu' completion
        -- WinBar         { }, -- Window bar of current window
        -- WinBarNC       { }, -- Window bar of not-current windows

        -- Common vim syntax groups used for all kinds of code and markup.
        -- Commented-out groups should chain up to their preferred (*) group
        -- by default.
        --
        -- See :h group-name
        --
        -- Uncomment and edit if you want more specific syntax highlighting.

        Comment({ fg = core_darkest }), -- Any comment

        Constant({ fg = core_dark, gui = "bold" }), -- (*) Any constant
        String({ fg = sunset, gui = "italic" }), --   A string constant: "this is a string"
        -- Character      { }, --   A character constant: 'c', '\n'
        -- Number         { }, --   A number constant: 234, 0xff
        -- Boolean        { }, --   A boolean constant: TRUE, false
        -- Float          { }, --   A floating point constant: 2.3e10

        Identifier({ fg = core_light }), -- (*) Any variable name
        Function({ fg = gray }), --   Function name (also: methods for classes)

        -- Statement      { }, -- (*) Any statement
        -- Conditional    { }, --   if, then, else, endif, switch, etc.
        -- Repeat         { }, --   for, do, while, etc.
        -- Label          { }, --   case, default, etc.
        Operator({ gui = "bold" }), --   "sizeof", "+", "*", etc.
        Keyword({ fg = gray_dark, gui = "bold" }), --   any other keyword
        -- Exception      { }, --   try, catch, throw

        -- PreProc        { }, -- (*) Generic Preprocessor
        -- Include        { }, --   Preprocessor #include
        -- Define         { }, --   Preprocessor #define
        -- Macro          { }, --   Same as Define
        -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

        Type({ fg = green }), -- (*) int, long, char, etc.
        -- StorageClass   { }, --   static, register, volatile, etc.
        -- Structure      { }, --   struct, union, enum, etc.
        -- Typedef        { }, --   A typedef

        Special({ fg = green }), -- (*) Any special symbol
        -- SpecialChar    { }, --   Special character in a constant
        -- Tag            { }, --   You can use CTRL-] on this
        -- Delimiter({  }), --   Character that needs attention
        -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
        -- Debug          { }, --   Debugging statements

        -- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
        -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
        -- Error          { }, -- Any erroneous construct
        -- Todo           { }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        -- These groups are for the native LSP client and diagnostic system. Some
        -- other LSP clients may use these groups, or use their own. Consult your
        -- LSP client's documentation.

        -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
        --
        -- LspReferenceText            { } , -- Used for highlighting "text" references
        -- LspReferenceRead            { } , -- Used for highlighting "read" references
        -- LspReferenceWrite           { } , -- Used for highlighting "write" references
        -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
        -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

        -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
        --
        DiagnosticError({ fg = red, bg = redBG, gui = "bold" }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticWarn({ fg = orange, bg = orangeBG, gui = "bold" }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticInfo({ fg = orange, bg = orangeBG, gui = "bold" }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticHint({ fg = orange, bg = orangeBG, gui = "bold" }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
        -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
        -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
        -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
        -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
        DiagnosticUnderlineError({ fg = red, bg = redBG, gui = "bold" }), -- Used to underline "Error" diagnostics.
        DiagnosticUnderlineWarn({ fg = orange, bg = orangeBG, gui = "bold" }), -- Used to underline "Warn" diagnostics.
        DiagnosticUnderlineInfo({ fg = orange, bg = orangeBG, gui = "bold" }), -- Used to underline "Info" diagnostics.
        DiagnosticUnderlineHint({ fg = orange, bg = orangeBG, gui = "bold" }), -- Used to underline "Hint" diagnostics.
        DiagnosticUnnecessary({ fg = orange, bg = orangeBG, gui = "bold" }),
        -- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
        -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
        -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
        -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
        -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
        -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
        -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

        -- Tree-Sitter syntax groups.
        --
        -- See :h treesitter-highlight-groups, some groups may not be listed,
        -- submit a PR fix to lush-template!
        --
        -- Tree-Sitter groups are defined with an "@" symbol, which must be
        -- specially handled to be valid lua code, we do this via the special
        -- sym function. The following are all valid ways to call the sym function,
        -- for more details see https://www.lua.org/pil/5.html
        --
        -- sym("@text.literal")
        -- sym('@text.literal')
        -- sym"@text.literal"
        -- sym'@text.literal'
        --
        -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

        -- sym"@text.literal"      { }, -- Comment
        -- sym"@text.reference"    { }, -- Identifier
        -- sym"@text.title"        { }, -- Title
        -- sym"@text.uri"          { }, -- Underlined
        -- sym"@text.underline"    { }, -- Underlined
        -- sym"@text.todo"         { }, -- Todo
        -- sym"@comment"           { }, -- Comment
        -- sym"@punctuation"       { }, -- Delimiter
        -- sym"@constant"          { }, -- Constant
        -- sym"@constant.builtin"  { }, -- Special
        -- sym"@constant.macro"    { }, -- Define
        -- sym"@define"            { }, -- Define
        -- sym"@macro"             { }, -- Macro
        -- sym"@string"            { }, -- String
        -- sym"@string.escape"     { }, -- SpecialChar
        -- sym"@string.special"    { }, -- SpecialChar
        -- sym"@character"         { }, -- Character
        -- sym"@character.special" { }, -- SpecialChar
        -- sym"@number"            { }, -- Number
        -- sym"@boolean"           { }, -- Boolean
        -- sym"@float"             { }, -- Float
        -- sym"@function"          { }, -- Function
        -- sym"@function.builtin"  { }, -- Special
        -- sym"@function.macro"    { }, -- Macro
        -- sym"@parameter"         { }, -- Identifier
        -- sym"@method"            { }, -- Function
        -- sym"@field"             { }, -- Identifier
        -- sym"@property"          { }, -- Identifier
        -- sym"@constructor"       { }, -- Special
        -- sym"@conditional"       { }, -- Conditional
        -- sym"@repeat"            { }, -- Repeat
        -- sym"@label"             { }, -- Label
        -- sym"@operator"          { }, -- Operator
        -- sym"@keyword"           { }, -- Keyword
        -- sym"@exception"         { }, -- Exception
        sym("@variable")({ fg = core }), -- Identifier
        -- sym"@type"              { }, -- Type
        -- sym"@type.definition"   { }, -- Typedef
        -- sym"@storageclass"      { }, -- StorageClass
        -- sym"@structure"         { }, -- Structure
        -- sym"@namespace"         { }, -- Identifier
        -- sym"@include"           { }, -- Include
        -- sym"@preproc"           { }, -- PreProc
        -- sym"@debug"             { }, -- Debug
        -- sym"@tag"               { }, -- Tag

        -- language specific
        -- html
        sym("@tag.attribute.tsx")({ fg = core_dark }), -- Tag

        -- rust
        sym("@lsp.typemod.namespace.library.rust")({ fg = gray_dark, gui = "bold" }), -- Tag
        sym("@lsp.type.enumMember.rust")({ fg = green }), -- Tag

        -- plugins
        MiniCursorword({ gui = "underline" }),
        MiniTablineTabpagesection({ fg = green, gui = "bold" }),
        FlashLabel({ fg = green, bg = hazy }),

        -- custom
        HighlightYank({ bg = flash }),
    }
end)

-- :T

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
