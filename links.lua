local filters = pandoc.List{}

local HOME = os.getenv "HOME"

-------------------------------------------------------------------------------
-- mémorisation du premier header à utiliser comme titre s'il n'est pas défini
-------------------------------------------------------------------------------

local first_header = nil

filters:insert {
    Header = function(header)
        if first_header ~= nil then return end
        first_header = pandoc.utils.stringify(header)
    end,
}

-------------------------------------------------------------------------------
-- définition du titre s'il n'est pas défini explicitement
-------------------------------------------------------------------------------

filters:insert {
    Meta = function(meta)
        meta.title = meta.title or first_header
        return meta
    end,
}

-------------------------------------------------------------------------------
-- correction des liens internes aux projets vers codeberg
-------------------------------------------------------------------------------

filters[#filters].RawBlock = filters[#filters].RawInline

-------------------------------------------------------------------------------
-- liste complète des filtres
-------------------------------------------------------------------------------

return filters
