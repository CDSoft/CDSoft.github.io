local F = require "F"

var "builddir" ".build"

---------------------------------------------------------------------
-- Main page
---------------------------------------------------------------------

build.lsvg.svg : add "args" "-- $args" : set "depfile" "$builddir/$out.d"

build.ypp
    : add "flags" {
        "-l cdsoft.lua",
        --"--img", "img",
        "--meta", "$builddir",
    }
    : add "implicit_in" {
        "cdsoft.lua",
    }

local html = build.pandoc : new "pandoc.html"
    : add "flags" {
        "--from markdown+emoji",
        "--to html5",
        "--email-obfuscation=javascript",
        "--mathjax",
        "--css", "cdsoft.css",
        --"--embed-resources",
        "--standalone",
        "--toc",
        "--toc-depth=2",
        "--lua-filter links.lua",
        "-H icon.i -H flattr.i -B $header -A $footer",
    }
    : add "implicit_in" {
        "cdsoft.css",
        "$builddir/header.html",
        "$builddir/footer.html",
        "icon.i", "favicon.svg",
        "flattr.i",
        "links.lua",
    }

local header = build.pandoc : new "pandoc-header.html"
    : add "flags" {
        "--from markdown+emoji",
        --"--to html5",
        "--email-obfuscation=javascript",
        "--mathjax",
    }

local header_html = header "$builddir/header.html" {
    build.ypp "$builddir/header.md" { "header.i" }
}
local footer_html = header "$builddir/footer.html" {
    build.ypp "$builddir/footer.md" { "footer.i" }
}

ls "*.md" : foreach(function(md)
    local out = md:chext".html"
    local page = md:splitext()
    html(out) {
        build.ypp("$builddir"/page/page..".md") { md },
        header = header_html,
        footer = footer_html,
        implicit_in = { header_html, footer_html },
    }
end)

build.lsvg.svg "luax-logo.svg" { "../luax/doc/src/luax-logo.lua" }
build.lsvg.svg "favicon.svg" { "icon.lua", args=32 }

ls("*.ypp", true) : foreach(function(file)
    build.ypp(file:splitext()) { file }
end)

build.cp "get-luax.sh"     "../luax-releases/get-luax.sh"
build.cp "get-pandoc.sh"   "../luax-releases/get-pandoc.sh"
build.cp "get-typst.sh"    "../luax-releases/get-typst.sh"
build.cp "get-plantuml.sh" "../luax-releases/get-plantuml.sh"
build.cp "get-ditaa.sh"    "../luax-releases/get-ditaa.sh"
build.cp "get-lzip.sh"     "../luax-releases/get-lzip.sh"
build.cp "get-lz4.sh"      "../luax-releases/get-lz4.sh"

---------------------------------------------------------------------
-- Redirections
---------------------------------------------------------------------

rule "redirect" {
    description = "redirect $out",
    command = "./redirect.lua $out $target",
    implicit_in = "redirect.lua",
}

local function redirect(name, target)
    build(name..".html") { "redirect", target=target }
end

redirect "abp"
redirect "bang"
redirect "bonaluna"
redirect("bl", "bonaluna")
redirect "calculadoira"
redirect "dedup"
redirect "dups"
redirect "fizzbuzz"
redirect "fu"
redirect "haskell-countdown"
redirect "haskell-fibonacci"
redirect "haskell-mastermind"
redirect "haskell-nqueens"
redirect "haskell-snake"
redirect "haskell-sudoku"
redirect "hcalc"
redirect "icd"
redirect "lapp"
redirect "lsvg"
redirect "lua-cpp"
redirect "lua-fibonacci"
redirect "luapack"
redirect "luax"
redirect "luax-releases"
redirect "lz4-builder"
redirect "lzip-builder"
redirect "ninja-builder"
redirect "panda"
redirect "plua"
redirect "popf"
redirect "pp"
redirect "push"
redirect "pwd"
redirect "pylog"
redirect "req"
redirect "rrpi"
redirect "sp"
redirect "std"
redirect "tagref"
redirect "todo"
redirect "tpg"
redirect "tt"
redirect "upp"
redirect "xcwd"
redirect "ypp"

---------------------------------------------------------------------
-- CV
---------------------------------------------------------------------

local cv = build.pandoc : new "pandoc_cv"
    : insert "cmd" {
        "QT_QPA_PLATFORMTHEME=kde",
        "QT_STYLE_OVERRIDE=qt5ct-style",
    }
    : add "flags" {
        "--to html5",
        "--standalone --embed-resources",
        "--email-obfuscation=javascript",
        "--css", "cv/cv.css",
        "-f markdown+emoji",
        --"-H icon.i",

        -- PDF options
        "--pdf-engine=wkhtmltopdf",
        "-V margin-left=1cm",
        "-V margin-right=1cm",
        "-V margin-top=1cm",
        "-V margin-bottom=1cm",
        "-V papersize=A4",
    }
    : add "implicit_in" "cv/cv.css"

local function once(f)
    local cache = {}
    return F.curry(function(x, y)
        local hash = F.show{x, y}
        local val = cache[hash]
        if val ~= nil then return val end
        val = f(x)(y)
        cache[hash] = val
        return val
    end)
end
local ypp_once = once(build.ypp)

F{".en", ".fr"}    : foreach(function(lang)
F{".html", ".pdf"} : foreach(function(format)
F{"", ".short"}    : foreach(function(size)
    local md = "cv"/"cv"..lang..size..".md"
    local out = "cv"/"cv"..lang..size..format
    local page = md:splitext()
    cv(out) {
        ypp_once("$builddir"/page/page..".md") { md },
    }
end) end) end)

build.cp "cv/index.html" { "cv/cv.en.html" }

build.lsvg.svg "cv/cdelord-card.svg" { "cv/card.lua" }
