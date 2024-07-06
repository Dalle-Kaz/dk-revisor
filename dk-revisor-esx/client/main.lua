if Config.Command.useCommand then
	RegisterCommand(Config.Command.command, function()
		openTablet()
	end, false)
end

if Config.useoxtaget == true then
	for index, coords in ipairs(Config.OpenPlaces) do
		exports.ox_target:addBoxZone({
			coords = coords,
			size = vector3(2, 2, 2),
			drawSprite = false,
			options = {
				{
					name = "revisor_tablet_" .. index,
					label = "Åben Revisor Tablet",
					icon = "fa-solid fa-receipt", 
					iconColor = "gold",
					distance = 2,
					onSelect = function()
						openTablet()
					end,
					canInteract = function() 
						if lib.callback.await('dalle:jobcheck', false) then
							return true
						else
							return false
						end
					end
				},
			},
		})
	end
end

function openTablet()
	local hasjob = lib.callback.await('dalle:jobcheck', false)
	if hasjob then
		Tablet()

		local input = lib.inputDialog("Revisor Menu", {
			{ type = "number", label = "Antal Penge.", description = "Her skriver du antallet af penge du vil hvidevaske", min = 1, default = 0, icon = "sack-dollar" }, 
			{ type = "number", label = "Id på person.", description = "Id på person som du hvidevasker pengene for", min = 1, default = 1, icon = "id-card" },
			{ type = "number", label = "Hvor meget procet tager du.", description = "Det er hvor meget du tager for at hvidevaske pengene", max = Config.Rules.MaxPercentage, min = 0, default = 0, icon = "percent" }, 
		})

		if not input then
			TriggerEvent("revisor:Notify", source, "Du har ikke udfyldt alt.", "error", "Revisor")
		elseif input then
			lib.callback.await('dalle:hvidevask', false, input[1], input[2], input[3])
		end

		RemoveTablet()
	end
end

function Tablet()
	local playerPed = PlayerPedId()
	local dict = "amb@world_human_seat_wall_tablet@female@base"
	RequestAnimDict(dict)
	tabletObject = CreateObject(GetHashKey("prop_cs_tablet"), GetEntityCoords(playerPed), 1, 1, 1)
	AttachEntityToEntity(tabletObject,playerPed,GetPedBoneIndex(playerPed, 28422),0.0,0.0,0.03,0.0,0.0,0.0,1,1,0,1,0,1)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	if not IsEntityPlayingAnim(playerPed, dict, "base", 3) then
		TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
	end
end

function RemoveTablet()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	if DoesObjectOfTypeExistAtCoords(coords.x, coords.y, coords.z, 0.9, GetHashKey("prop_cs_tablet"), true) then
		spike = GetClosestObjectOfType(coords.x, coords.y, coords.z, 0.9, GetHashKey("prop_cs_tablet"), false, false, false)
		SetEntityAsMissionEntity(spike, true, true)
		DeleteObject(spike)
		ClearPedTasks(ped)
	end
end