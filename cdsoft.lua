local F = require "F"
local sh = require "sh"

-- Some obfuscation against those fucking bots
local booThi1M = ("731909a5c6b2ee"):unhex():unarc4"christophe"
local Idohtie6 = 3
local Thah2pa2 = ("9e8b329975a737"):unhex():unarc4"delord"
email = booThi1M.."-"..Idohtie6.."@"..Thah2pa2..".fr"

-- Personal information

local one_year = 365.25 * 24 * 60 * 60
local sopra = {
    t0 = os.time { year=1998, month=10, day=1 },
    t1 = os.time { year=2017, month=2, day=2 },
}
local easymile = {
    t0 = os.time { year=2017, month=2, day=6 },
    t1 = os.time()
}

BIRTH = {year=1975, month=4, day=13}
PPM = F.floor(F.round(330.5))
AGE = math.floor((os.time() - os.time(BIRTH)) / one_year)
YEARS_AT_WORK = math.floor((easymile.t1 - sopra.t0) / one_year)
YEARS_AT_SOPRA = math.floor((sopra.t1 - sopra.t0) / one_year)
YEARS_AT_EASYMILE = math.floor((easymile.t1 - easymile.t0) / one_year)

-- Shortcuts

function gh(repo)
    return ("[%s](https://github.com/CDSoft/%s)"):format(repo, repo:lower())
end

function link(repo)
    return ("[%s](%s.html)"):format(repo, repo:lower())
end

function oldgh(name, new)
    if type(new) == "table" then
        new = F.map(gh, new) : str(", ", " or ")
    else
        new = gh(new)
    end
    return ("%s (*discontinued, consider using %s instead*)"):format(gh(name), new)
end

function oldlink(name, new)
    if type(new) == "table" then
        new = F.map(link, new) : str(", ", " or ")
    else
        new = gh(new)
    end
    return ("%s (*discontinued, consider using %s instead*)"):format(link(name), new)
end

-- htaccess macros

function redirect(name, aliases)
    local i = F.I { name=name }
    aliases = aliases or {}
    return F.flatten {
        i"Redirect permanent /$(name)            https://github.com/CDSoft/$(name)",
        i"Redirect permanent /$(name)/index.html https://github.com/CDSoft/$(name)",
        i"Redirect permanent /$(name).html       https://github.com/CDSoft/$(name)",
        F(aliases) : map(function(alias)
            local j = i { alias=alias }
            return {
                j"Redirect permanent /$(alias)            https://github.com/CDSoft/$(name)",
                j"Redirect permanent /$(alias)/index.html https://github.com/CDSoft/$(name)",
                j"Redirect permanent /$(alias).html       https://github.com/CDSoft/$(name)",
            }
        end)
    }
end
