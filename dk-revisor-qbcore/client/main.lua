local QBCore = exports['qb-core']:GetCoreObject()
local coords = false

if Config.usecommand then
	RegisterCommand(Config.command.command, function(source, args)
		local Player = QBCore.Functions.GetPlayerData()
		local jobName = Player.job.name

		if jobName == Config.job then
			if Config.command.NeedsToBeInZone then
				ZoneCheck()
			else
				openmenu()
			end
		else
			QBCore.Functions.Notify(Config.Lang['perm_error'], 'error', 5000)
		end
	end)
end

if Config.UsingQbTarget then
	for index, coords in pairs(Config.OpenPlaces) do
		exports['qb-target']:AddBoxZone("Revisor_" .. index, coords, 2, 3, 
			{
				name = "Revisor_" .. index,
				heading = 0,
				debugPoly = false,
			}, 
			{ options = {
				{
					icon = "fas fa-sign-in-alt",
					label = Config.Lang['open_accountant'], 
					action = function() openmenu() end
				},
			},
			distance = 2.5
		})
	end
end

function openmenu()
	local Player = QBCore.Functions.GetPlayerData()

	if not lib.progressActive() then -- If the player doesnt have a progress active then --
		if Player.job.name == Config.job then -- Player has the job --
			local input = nil

			if Config.Roles.ClosestPlayers then -- Roles thingy -- 
				local PlayersForInput = lib.callback.await('dalle:playerinfo', false, QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 5.0))
				
				if PlayersForInput then
					input = lib.inputDialog(Config.Lang['accountant_menu_title'], {
						{
							type = "number",
							label = Config.Lang['money_ammount'],
							description =  Config.Lang['money_ammount_bio'],
							min = 1,
							default = 0,
							icon = "sack-dollar",
						}, 
						{
							type = "select",
							label = Config.Lang['id_players'],
							description = Config.Lang['id_players_bio'],
							icon = "id-card",
							options = PlayersForInput,
						},
						{
							type = "number",
							label = Config.Lang['take_procent'],
							description = Config.Lang['take_procent_bio'],
							max = Config.Rules.MaxPercentage,
							min = 0,
							default = 0,
							icon = "percent",
						}, 
					})
				else
					return QBCore.Functions.Notify(Config.Lang['invalid_space'], 'error', 5000)
				end
			else
				input = lib.inputDialog(Config.Lang['accountant_menu_title'], {
					{
						type = "number",
						label = Config.Lang['money_ammount'],
						description =  Config.Lang['money_ammount_bio'],
						min = 1,
						default = 0,
						icon = "sack-dollar",
					}, 
					{
						type = "number",
						label = Config.Lang['id_players'],
						description = Config.Lang['id_players_bio'],
						min = 1,
						default = 1,
						icon = "id-card",
					},
					{
						type = "number",
						label = Config.Lang['take_procent'],
						description = Config.Lang['take_procent_bio'],
						max = 50,
						min = 0,
						default = 0,
						icon = "percent",
					}, 
				})
			end

			Tablet()

			if not input then
				if Config.command.NeedsToBeInZone then coords = false end

				QBCore.Functions.Notify(Config.Lang['invalid_space'], 'error', 5000)

				--return RemoveTablet()
			elseif input then
				local playeronline = lib.callback.await('revisor:playeronline', false, input[2])
				
				if not playeronline then
					QBCore.Functions.Notify(Config.Lang['not_online'], 'error', 5000)
					return RemoveTablet()
				end

				local durationTime = input[1] > Config.MaxMoney and Config.Time or input[1] * Config.Time

				if durationTime > Config.MaxTime then
					durationTime = Config.MaxTime
				end

				if lib.progressCircle({ duration = durationTime, position = 'bottom', useWhileDead = false, canCancel = true, disable = { combat = true, car = true, move = true, } }) then
					local washed = lib.callback.await('revisor:Hvidevask-Penge', false, input[1], input[2], input[3])
					if Config.command.NeedsToBeInZone then
						coords = false
					end
				else
					QBCore.Functions.Notify(Config.Lang['cancled'], 'error', 5000)
				end	
			end
		else
			QBCore.Functions.Notify(Config.Lang['perm_error'], 'error', 5000)
		end
	else
		QBCore.Functions.Notify(Config.Lang['proccessing_error'], 'error', 5000)
	end	

	RemoveTablet()
end

function Tablet()
	local playerPed = PlayerPedId()
	local dict = "amb@world_human_seat_wall_tablet@female@base"

	RequestAnimDict(dict)
	tabletObject = CreateObject(GetHashKey("prop_cs_tablet"), GetEntityCoords(playerPed), 1, 1, 1)
	AttachEntityToEntity(tabletObject, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

	while not HasAnimDictLoaded(dict) do
		Wait(100)
	end

	if not IsEntityPlayingAnim(playerPed, dict, "base", 3) then
		TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
	end
end

function RemoveTablet()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	if DoesObjectOfTypeExistAtCoords(coords.x, coords.y, coords.z, 0.9, GetHashKey("prop_cs_tablet"), true) then
		tablet = GetClosestObjectOfType(coords.x, coords.y, coords.z, 0.9, GetHashKey("prop_cs_tablet"), false, false, false)
		SetEntityAsMissionEntity(tablet, true, true)
		DeleteObject(tablet)
		ClearPedTasks(ped)
	end
end

function ZoneCheck()
	local playerCoords = GetEntityCoords(PlayerPedId())
	local maxDistance = Config.command.Distance
	
	for _, zoneCoords in pairs(Config.OpenPlaces) do
		local distance = #(playerCoords - zoneCoords)

		if distance <= maxDistance then
			coords = true
			openmenu()
			return
		end
	end

	if coords == false then
		QBCore.Functions.Notify(Config.Lang['location_error'], 'error', 5000)
	end
end