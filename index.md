# CDSoft / Christophe Delord

## Important

These pages are outdated.

I'm migrating my Github repositories to [Codeberg](https://codeberg.org/cdsoft).

Please visit [codeberg/cdsoft](https://codeberg.org/cdsoft) and [cdsoft.codeberg.page](https://cdsoft.codeberg.page) instead.

## About me

Welcome to my personal web site.

Some resources are available here, mainly free softwares.

:::{.card}
[![](cv/cdelord-card.svg){height=12em}](cv/cv.en.html)
:::

Feel free to contact me or support my work:

- [CV/Resume](cv/cv.en.html)
- [email](mailto:@email)
- [Codeberg](https://codeberg.org/cdsoft)
- [Github](https://github.com/CDSoft)
- [LinkedIn](https://www.linkedin.com/in/cdelord/)
- [![I'm a Haskeller](cv/haskeller.png)](https://www.haskellers.com/user/cdsoft)

@@[[ donate = function(url) return function(img) return function(alt)
    return ("<a href='%s' target='_blank'><img height='36' style='border:0px;height:36px;' src='%s' border='0' alt='%s' /></a>"):format(url, img, alt)
end end end]]

@donate "https://liberapay.com/LuaX/donate"  "https://liberapay.com/assets/widgets/donate.svg" "Donate using Liberapay"
@donate "https://ko-fi.com/K3K11CD108"       "https://storage.ko-fi.com/cdn/kofi6.png?v=6"     "Buy Me a Coffee at ko-fi.com"

## News

@include "news.i"

## Professional activity

I have a strong experience in critical domains in aeronautics
(DO178B, @YEARS_AT_SOPRA years at Sopra for Airbus, Thales, Liebherr, ...)
and autonomous vehicles (ISO 26262, @YEARS_AT_EASYMILE years at [EasyMile](http://www.easymile.com/)).

I'm currently working at [EasyMile](http://www.easymile.com/) for more than @YEARS_AT_EASYMILE years
where I'm developing a multicore real-time critical software in C.
The simulation and test environment is fully made in [Haskell](https://www.haskell.org/).

For further information, you can read my [resume](cv/cv.en.html).

## Personal projects

I'm found of free and open source softwares.
I'm working with GNU/Linux and programming most of the time in Haskell, Lua and C.
This page lists some of my personal projects.

**Note**: these projects are available on <@git_url>.
It is generally highly recommended to recompile them from sources.
In case you need some precompiled binaries, some can be found here: [pub](@storage_url/pub).

@comment[[
## Programming

* @(gh "hey"):
  helper script to install some <@git_url> programs and related softwares.

* @(oldgh("makex", "hey")):
  Some projects presented here are based on Lua and share a common infrastructure (LuaX, Pandoc, ypp, lsvg, ...).
  `makex.mk` is a Makefile that can be included in other Makefiles to automatically install LuaX and other Lua based programs.
]]

## Lua / LuaX

* @(gh "LuaX"): Lua eXtended.
  A simple Lua interpretor and compiler for Linux, MacOS and Windows, using [Zig](https://ziglang.org/) as a cross-compiler.
* @(gh "bang"): Ninja file generator scriptable in LuaX.
* @(gh "Calculadoira"): a real programmer calculator using LuaX.
* @(gh "lua-fibonacci"): Various Fibonacci implementations in Lua (to test ypp and typst).
* @(gh "tagref"): helps you maintain cross-references in your code.

@comment[[
## C

* @(gh "std"): "Standard C library" providing some containers and data structures for C programs.
]]

## Haskell

* @(gh "haskell-mastermind"): Play Mastermind with the computer
* @(gh "haskell-nqueens"): The classical N-Queens problem
* @(gh "haskell-snake"): Snake puzzle solver
* @(gh "haskell-sudoku"): Sudoku solver
* @(gh "haskell-fibonacci"): Various Fibonacci implementations
* @(gh "haskell-countdown"): Countdown in Haskell

<!-- -->

* @(oldgh("hCalc", "calculadoira")): a real programmer calculator

## Python

My Python scripts are old and may not be maintained...

* @(gh "TPG") (Toy Parser Generator): A simple parser generator in Python. Easy to use and quite powerful.
* @(gh "sp") (Simple Parser): An other parser generator in Python.
* @(gh "dups"): find duplicate files
* @(gh "PopF"): A simple but powerful POP3 SPAM filter
* @(gh "PyLog"): PROLOG like engine for Python

## Pandoc, text preprocessing, image generators

### In Lua / LuaX

* @(gh "ypp"): Yet a PreProcessor. It’s an attempt to merge UPP and Panda. It acts as a generic text preprocessor as UPP and comes with macros reimplementing most of the Panda functionalities (i.e. Panda facilities not restricted to Pandoc).
* @(gh "panda"): Panda - Pandoc add-ons (Lua filters for Pandoc). A lightweight abp alternative.
* @(gh "lsvg"): LuaX interpreter specialized to generate SVG, PNG and PDF images.

<!-- -->

* @(oldgh("upp", "ypp")): Universal PreProcessor. A lightweight pp alternative.

### In Haskell

* @(oldgh("abp", {"ypp", "panda"})): Abstract Preprocessor for Pandoc AST.
* @(oldgh("pp", "ypp")): Generic Preprocessor for Pandoc inspired by DPP/GPP.

## Vim

* @(gh "todo"): basic but efficient todo list plugin for Vim
* @(gh "pwd"): basic but efficient password manager plugin for Vim

## Cloud

* @(gh "rrpi"): Personal cloud on a Raspberry Pi 4 or 5

@comment[[
## Books

* [Essays](essays/index.html)
]]

## Student projects / artificial intelligence

* [tools in Prolog](http://christophe.delord.free.fr/ai/index.html): Prolog tools written during my studies
* [dialog](http://christophe.delord.free.fr/ai/dea.html): Speech Acts and Dialogue Games
