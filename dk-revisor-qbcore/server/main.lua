local QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('revisor:Hvidevask-Penge', function(source, antalPenge, idPaaPerson, procet)

    local player = QBCore.Functions.GetPlayer(idPaaPerson)
    local revisor = QBCore.Functions.GetPlayer(source)
            

    if player.license  == revisor.license then 
        TriggerClientEvent('QBCore:Notify', source, Config.Lang['you_are_accountant_error'], "error", 5000)
        return
    end
    
    if revisor.PlayerData.job.name == Config.job then
        TriggerClientEvent('QBCore:Notify', source, Config.Lang['person_is_accountant_error'], "error", 5000)
        return
    end
    
    if revisor.PlayerData.job.name == Config.job then
        if player then
            if player.Functions.RemoveItem(Config.Item, antalPenge) then
                local amountToReceive  = math.ceil(antalPenge - (antalPenge * procet / 100))
        
                player.Functions.AddMoney("bank", amountToReceive)
        
                local amountForRevisor = antalPenge - amountToReceive
                revisor.Functions.AddMoney("bank", amountForRevisor)
        
                TriggerClientEvent('QBCore:Notify', source, Config.Lang['washed'] .. (amountToReceive or 0), "success", 5000)
                TriggerClientEvent('QBCore:Notify', source, Config.Lang['earned'] .. (amountForRevisor or 0), "success", 5000)                        
                sendToDiscord(Config.webhook, tostring(revisor.PlayerData.license), tostring(amountToReceive), tostring(player.PlayerData.license), tostring(amountForRevisor), tostring(antalPenge))
                
                return true
            else
                TriggerClientEvent('QBCore:Notify', source, Config.Lang['not_enough_money'], "error", 5000)
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Config.Lang['not_online'], "error", 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Config.Lang['perm_error'], "error", 5000)
    end
    return false
end)


-- Dont fucking know why this --
lib.callback.register('revisor:playeronline', function(source, idPaaPerson)
    local player = QBCore.Functions.GetPlayer(idPaaPerson)

    if player then
        return true
    end

    return false
end)

lib.callback.register('dalle:playerinfo', function(source, players)
    if players then
        local PlayersForInput = {}
        for k, Player in pairs(players) do 
            local PlayerData = QBCore.Functions.GetPlayer(Player)
            
            table.insert(PlayersForInput, {
                value = Player
                label = GetName(Player)
            })
        end
        return PlayersForInput
    end

    return false
end)

function GetName(source)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    return ("%s %s"):format(qPlayer.PlayerData.charinfo.firstname, qPlayer.PlayerData.charinfo.lastname)
end

function sendToDiscord(webhook, revisorid, amountToReceive, idPaaPerson, amountForRevisor, antalPenge)
    local embed = {
        {
            ["title"] = "Hvidevaske Information",
            ["color"] = 65280,
            ["fields"] = {
                {["name"] = Config.Lang['money_amount'], ["value"] = antalPenge, ["inline"] = true},
                {["name"] = Config.Lang['id_accountant'], ["value"] = revisorid, ["inline"] = true},
                {["name"] = Config.Lang['id_player'], ["value"] = idPaaPerson, ["inline"] = true},
                {["name"] = Config.Lang['player_earned'], ["value"] = amountToReceive, ["inline"] = true},
                {["name"] = Config.Lang['accountant_earned'], ["value"] = amountForRevisor, ["inline"] = true},
            }
        }
    }

    PerformHttpRequest(webhook,
        function(err, text, headers) end,
        'POST',
        json.encode({embeds = embed}),
        { ['Content-Type'] = 'application/json' }
    )
end