local Translations = {
    menu = {
        arcade = "Arcade cabinet",
        special = "Special button!",    
        purchase_token = "Purchase token | Price $ %s",
        amount = "Amount",
    },
    target = {
        arcade = "Arcade cabinet",
        special = "Special button!!",
    },
    interactions = {
        enter_token_shop = "Purchase gametoken"
    },
    error = {
        no_token_title = "Arcade Cabinet",
        no_token = "You need a Game Token to use this.",
        not_enough_money_title = "Gametokens",
        not_enough_money = "You don't have enough money to buy this amount of tokens.",
    },
}

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
