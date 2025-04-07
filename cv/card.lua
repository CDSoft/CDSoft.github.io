local fs = require "fs"
local sh = require "sh"

local k = 20
local X, Y = 88*k, 58*k

local MARGIN = 1*k

local WHITE = "#eeeeee"
local BLUE = "#4c628b"

local URL = "https://cdelord.fr"
local TEL = ""

img {
    width=X, height=Y,
    text_anchor = "middle",
}

local function border()
    return G {
        Rect { x=MARGIN, y=MARGIN, width=X-2*MARGIN, height=Y-2*MARGIN, fill=BLUE },
        Rect { x=2*MARGIN, y=2*MARGIN, width=X-4*MARGIN, height=Y-4*MARGIN, fill=WHITE },
    }
end

local function logo_lambda()
    local size = Y/2 - 3*MARGIN
    local haskeller = fs.read("cv/haskeller.png"):base64()
    img { ["xmlns:xlink"] = "http://www.w3.org/1999/xlink" }
    return G { transform=("translate(%.2f %.2f)"):format(2*MARGIN, size+4*MARGIN),
        Rect { x=0, y=0, width=size, height=size, fill=BLUE },
        Rect { x=size/4, y=size/4, width=size/2, height=size/2, fill=WHITE },
        Text "λ" { x=size/2, y=size/2, dy="0.35em", fill=BLACK, font_size=size, font_family="DejaVu Sans Condensed" },
        Raw(('<image x="%.2f" y="%.2f" width="%.2f" height="%.2f" xlink:href="data:image/png;base64,%s"/>'):format(
            0, size-size*18/149,
            size, size*18/149,
            haskeller
        )),
    }
end

local function logo_luax()
    local size = Y/2 - MARGIN
    local logo = fs.read(os.getenv"HOME"/"src/luax/doc/luax-logo.svg")
    return G { transform=("scale(%f) translate(%f %f)"):format(size/256, X*1/64, Y*1/64),
        Raw(logo),
        G {
            font_family = "Fira Code Medium",
            font_size = Y*2/128,
            Text "Lua"    { x=X* 2/128, y=Y* 3/128 },
            Text "bang"   { x=X*16/128, y=Y* 3/128 },
            Text "ypp"    { x=X* 1/128, y=Y*20/128 },
            Text "panda"  { x=X* 2/128, y=Y*24/128 },
            Text "pandoc" { x=X* 4/128, y=Y*27/128 },
            Text "lsvg"   { x=X*16/128, y=Y*24/128 },
        },
    }
end

local function qrcode(url)
    local size = Y/2 - 2*MARGIN
    local qr = sh.read(("qrencode -o - -t SVG --inline --svg-path --foreground=%s --background=%s '%s'"):format(
        BLUE:gsub("#", ""),
        WHITE:gsub("#", ""),
        url
    )):lines()
    local x1, y1, x2, y2 = qr[2]:match('viewBox="(.-)"'):words():map(tonumber):unpack()
    return G {
        Rect { x=X-size-MARGIN, y=Y-size-MARGIN, width=size, height=size, fill=BLUE },
        G {
            transform = ("translate(%.2f %.2f) scale(%.2f %.2f)"):format(
                X-size-x1, Y-size-y1,
                (size-2*MARGIN)/(x2-x1), (size-2*MARGIN)/(y2-y1)
            ),
            Raw(qr:init():drop(2):unlines()),
        },
    }
end

local function name()
    return G {
        font_family = "DejaVu Sans Condensed",
        Text "Christophe Delord"  { x=X*42/64, y=Y*10/64, font_size=Y*3/32, font_weight="bold" },
        Text "Software Engineer"  { x=X*42/64, y=Y*16/64, font_size=Y*2/32 },
        Text "Embedded Softwares" { x=X*42/64, y=Y*22/64, font_size=Y*2/32 },
        Text (URL)                { x=X*42/64, y=Y*28/64, font_size=Y*2/32 },
        Text (TEL)                { x=X*53/64, y=Y*31/64, font_size=Y*1/32 },
    }
end

local function skills()
    return G {
        font_family = "Fira Code Medium",
        Text "nats = 0 : map (+1) nats" { x=X*31/64, y=Y*32/64, font_size=Y*3/128, fill=BLUE },
        Text "C C++"                    { x=X*31/64, y=Y*38/64, font_size=Y*3/64, word_spacing="1em" },
        Text "Lua Python"               { x=X*31/64, y=Y*44/64, font_size=Y*3/64, word_spacing="0.75em" },
        Text "Haskell Prolog"           { x=X*31/64, y=Y*50/64, font_size=Y*3/64, word_spacing="0.5em" },
        Text "R&amp;D"                  { x=X*31/64, y=Y*56/64, font_size=Y*3/64, word_spacing="1em" },
    }
end

img {
    border(),
    logo_lambda(),
    logo_luax(),
    qrcode(URL),
    name(),
    skills(),
}
