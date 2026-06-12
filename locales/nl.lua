local Translations = {
    menu = {
        arcade = "Arcade kast",
        special = "Speciale knop",   
        purchase_token = "Koop token | Prijs: € %s",
        amount = "Aantal",
    },
    target = {
        arcade = "Arcade kast",
        special = "Speciale knop kab00m!",
    },
    interactions = {
        enter_token_shop = "Gametokens inkopen"
    },
    error = {
        no_token_title = "Arcadekast",
        no_token = "Je hebt een gametoken nodig om een spelletje te kunnen spelen.",
        not_enough_money_title = "Gametokens",
        not_enough_money = "Je hebt niet voldoende geld om een gametoken te kopen.",
    }
}

local currentLocale = GetConvar('qb_locale', 'en')

if currentLocale == 'nl' then
    local function parseLocale(table, key)
        local path = string.split(key, '.')
        local current = table
        for i = 1, #path do
            if current[path[i]] == nil then return key end
            current = current[path[i]]
        end
        return current
    end

    Lang = {}
    function Lang:t(key, ...)
        local str = parseLocale(Translations, key)
        if ... then
            return string.format(str, ...)
        end
        return str
    end
end
