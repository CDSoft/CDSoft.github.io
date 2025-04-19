---------------------------------------------------------------------
-- Main page
---------------------------------------------------------------------

local html = build.pandoc : new "pandoc.html"
    : add "flags" {
        "--from markdown+emoji",
        "--to html5",
        "--email-obfuscation=javascript",
        "--mathjax",
        "--css", "cdsoft.css",
        --"--embed-resources",
        "--standalone",
        --"--toc",
        --"--toc-depth=2",
    }
    : add "implicit_in" {
        "cdsoft.css",
    }

ls "*.md" : foreach(function(md)
    local out = md:chext".html"
    local page = md:splitext()
    html(out) {
        build.ypp("$builddir"/page/page..".md") { md },
        implicit_in = { header_html, footer_html },
    }
end)
