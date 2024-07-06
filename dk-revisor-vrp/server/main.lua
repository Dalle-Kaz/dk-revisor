local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")  

lib.callback.register('dalle:jobcheck', function(source)
    return vRP.hasGroup({vRP.getUserId({source}), Config.job})
end)

lib.callback.register('dalle:hvidevask', function(source, antalPenge, idPaaPerson, procet)
    local revisorid = vRP.getUserId({source})
    
    if revisorid then
        if idPaaPerson == nil then return TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Personen er ikke i byen', type = 'error' }) end

        if revisorid == idPaaPerson and not Config.Rules.WashOwn then
            return TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Du kan ikke hvidvaske dine egne penge', type = 'error' })
        end

        if vRP.hasGroup({idPaaPerson, Config.job}) and not Config.Rules.WashEmployees then
            return TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Du kan ikke hvidvaske personens penge da de selv er Revisor', type = 'error' })
        end

        if not vRP.hasGroup({revisorid, Config.job}) then
            return TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Du har ikke adgang til denne funktion', type = 'success' })
        end

        if vRP.tryGetInventoryItem({idPaaPerson, Config.DirtyMoney, antalPenge, true}) then
            local amountToReceive = math.ceil(antalPenge - (antalPenge * procet / 100))
            vRP.giveMoney({idPaaPerson, amountToReceive})

            local amountForRevisor = antalPenge - amountToReceive
            vRP.giveMoney({revisorid, amountForRevisor})
            
            TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Du har hvidvasket pengene', type = 'success' })
            sendToDiscord(Config.webhook, revisorid, amountToReceive, idPaaPerson, amountForRevisor, antalPenge)
        else
            TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Person har ikke nok penge', type = 'error' })
        end
    else
        TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Ikke noget gyldig ID', type = 'error' })
    end
end)

function sendToDiscord(webhook, revisorid, amountToReceive, idPaaPerson, amountForRevisor, antalPenge)
    local embed = {
        {
            ["title"] = "Hvidevaske Information",
            ["color"] = 65280,
            ["fields"] = {
                {["name"] = "Hvidevask Beløb:", ["value"] = antalPenge, ["inline"] = true},
                {["name"] = "Revisor ID:", ["value"] = revisorid, ["inline"] = true},
                {["name"] = "For Person ID:", ["value"] = idPaaPerson, ["inline"] = true},
                {["name"] = "Hvidevasket Beløb:", ["value"] = amountToReceive, ["inline"] = true},
                {["name"] = "Tjente Beløb:", ["value"] = amountForRevisor, ["inline"] = true}
            }
        }
    }

    PerformHttpRequest( webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' } )
end