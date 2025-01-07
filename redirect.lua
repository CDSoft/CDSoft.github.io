#!/usr/bin/env luax

local F = require "F"
local fs = require "fs"

local name = arg[1]
local target = arg[2] or name:splitext()

local i = F.I { target=target }

local redirection = i[[
<script>window.location.replace("https://github.com/CDSoft/$(target)")</script>
]]

fs.write(name, redirection)
fs.mkdirs(name:splitext())
fs.write(name:splitext()/"index.html", redirection)
