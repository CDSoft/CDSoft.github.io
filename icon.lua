local size = tonumber(arg[1] or 64)

local blue = "#4c628b"
local white = "#eeeeee"

img {
    width = size,
    height = size,
    font_size = size,
    text_anchor = "middle",
    font_family = "DejaVu Sans Condensed",
    Rect { x=0, y=0, width=size, height=size, stroke_width=0, fill=blue },
    Rect { x=size/4, y=size/4, width=size/2, height=size/2, stroke_width=0, fill=white },
    Text 'λ' { x=size/2, y=size/2, dy=size*3/8, fill="black" },
}
