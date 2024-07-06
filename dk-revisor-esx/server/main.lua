lib.callback.register('dalle:jobcheck', function(source)
    local xPlayer = ESX.GetPlayerFromId(source) 
    return xPlayer.getJob().name
end)

lib.callback.register('dalle:hvidevask', function(source, antalPenge, idPaaPerson, procet)
    local revisorid = ESX.GetPlayerFromId(source) 
    local yPlayer = ESX.GetPlayerFromId(idPaaPerson) 
    
    if revisorid then -- if the is real/online player then -- Dont know why its here 
        if yPlayer == nil then return TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Personen er ikke i byen', type = 'error' }) end -- If the other person it not online

        if revisorid == yPlayer and not Config.Rules.WashOwn then -- If is the same person and the roles doesnt allow that --
            return TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Du kan ikke hvidvaske dine egne penge', type = 'error' })
        end

        if (yPlayer.getJob().name == Cofnig.job) and not Config.Rules.WashEmployees then -- If the other person has the job and the roles doesnt allow that --
            return TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Du kan ikke hvidvaske personens penge da de selv er Revisor', type = 'error' })
        end

        if not (revisorid.getJob().name == Config.job) then -- If the player doesnt have the job then dont allow the player -- 
            return TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Du har ikke adgang til denne funktion', type = 'success' })
        end

        -- Invtory stuff -- 

        if exports.ox_inventory:RemoveItem(yPlayer, Config.DirtyMoney, antalPenge) then -- Removes item -- 
            local amountToReceive = math.ceil(antalPenge - (antalPenge * procet / 100))
            yPlayer.addMoney(amountToReceive)

            local amountForRevisor = antalPenge - amountToReceive
            xPlayer.addMoney(amountForRevisor)
            
            TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Du har hvidvasket pengene', type = 'success' })
            sendToDiscord(Config.webhook, revisorid, amountToReceive, yPlayer, amountForRevisor, antalPenge)
        else -- The other person doesnt have that much dirty money or any --
            TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Person har ikke nok penge', type = 'error' })
        end

    else -- Player nil --
        TriggerClientEvent('ox_lib:notify', source, { title = 'Tablet', description = 'Ikke noget gyldig ID', type = 'error' })
    end
end)


-- Standalone --

function sendToDiscord(webhook, revisorid, amountToReceive, idPaaPerson, amountForRevisor, antalPenge)
    local embed = {
        {
            ["title"] = "Hvidevaske Information",
            ["color"] = 65280,
            ["fields"] = {
                {["name"] = "Hvidevask Beløb:", ["value"] = antalPenge, ["inline"] = true},
                {["name"] = "Revisor Identifier:", ["value"] = revisorid.getIdentifier(), ["inline"] = true},
                {["name"] = "For Person Identifier:", ["value"] = idPaaPerson.getIdentifier(), ["inline"] = true}, 
                {["name"] = "Hvidevasket Beløb:", ["value"] = amountToReceive, ["inline"] = true},
                {["name"] = "Tjente Beløb:", ["value"] = amountForRevisor, ["inline"] = true}
            }
        }
    }

    PerformHttpRequest( webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' } )
end 