local F = require "F"

var "builddir" ".build"

---------------------------------------------------------------------
-- Main page
---------------------------------------------------------------------

local svg = pipe { build.lsvg.svg, build.cp }

build.ypp
    : add "flags" {
        "-l cdsoft.lua",
    }
    : add "implicit_in" {
        "cdsoft.lua",
    }

local ypp_md = build.ypp : new "ypp.md"

local md_to_html = pipe {
    ypp_md,
    build.pandoc : new "pandoc.html"
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
            "-H icon.i -H flattr.i -B $builddir/header.html -A $builddir/footer.html",
        }
        : add "implicit_in" {
            "cdsoft.css",
            "$builddir/header.html",
            "$builddir/footer.html",
            "icon.i", "favicon.svg",
            "flattr.i",
            "links.lua",
        }
}

local md_to_html_header = pipe {
    ypp_md,
    build.pandoc : new "pandoc-header.html"
        : add "flags" {
            "--from markdown+emoji",
            --"--to html5",
            "--email-obfuscation=javascript",
            "--mathjax",
        },
}

md_to_html_header "$builddir/header.html" { "header.i" }
md_to_html_header "$builddir/footer.html" { "footer.i" }

ls "*.md" : foreach(function(md)
    md_to_html(md:chext".html") { md }
end)

svg "luax-logo.svg" { "../luax/doc/src/luax-logo.lua" }
svg "favicon.svg" { "icon.lua", args=32 }

local ypp = pipe {
    build.ypp,
    build.cp,
}

ls("*.ypp", true) : foreach(function(file)
    ypp(file:splitext()) { file }
end)

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

local cv = pipe {
    ypp_md,
    build.pandoc : new "pandoc_cv"
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
        : add "implicit_in" "cv/cv.css",
}

F{".en", ".fr"}    : foreach(function(lang)
F{".html", ".pdf"} : foreach(function(format)
F{"", ".short"}    : foreach(function(size)
    cv("cv"/"cv"..lang..size..format) { "cv"/"cv"..lang..size..".md" }
end) end) end)

build.cp "cv/index.html" { "cv/cv.en.html" }

svg "cv/cdelord-card.svg" { "cv/card.lua" }
