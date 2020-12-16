local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local current = 0;
local ESX = nil
local time = 0
local gangs = false
local title = ""

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerEvent('es:setMoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)
	--SendNUIMessage({action="off"})

end)


Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1000)

		if time > 0 then
		time = time - 1
		SendNUIMessage({action = "timer", key = title, value = time, gang = gangs})
		else 
			SendNUIMessage({action = "timer", key = title, value = 0, gang = gangs})

		end

	end

end)


RegisterNetEvent('ui:timer')
AddEventHandler('ui:timer', function(timex, titlex) 
	
	time = timex
	title = titlex
	
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	
	
	local data = xPlayer
	local accounts = data.accounts

	
	SendNUIMessage({action = "setValue", key = "id", value = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))})

	for k, v in pairs(accounts) do
		local account = v
		if account.name == "bank" then
			SendNUIMessage({action = "setValue", key = "bankmoney", value = "€" .. account.money})
		elseif account.name == "black_money" then
			SendNUIMessage({action = "setValue", key = "dirtymoney", value = "€" .. account.money})
		end
	end
	SendNUIMessage({action = "setValue", key = "job", value = data.job.label .. " - " .. data.job.grade_label})
	SendNUIMessage({action = "setValue", key = "job2", value = data.job2.label .. " - " .. data.job2.grade_label})
	SendNUIMessage({action = "setValue", key = "money", value = "€" .. data.money})

	SendNUIMessage({action="on"})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "bank" then
		SendNUIMessage({action = "setValue", key = "bankmoney", value = "€" .. account.money})
	elseif account.name == "black_money" then
		SendNUIMessage({action = "setValue", key = "dirtymoney", value = "€" .. account.money})
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	SendNUIMessage({action = "setValue", key = "job", value = job.label .. " - " .. job.grade_label})
end)


RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	SendNUIMessage({action = "setValue", key = "job2", value = job2.label .. " - " .. job2.grade_label})

end)
RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({action = "setValue", key = "money", value = "€" .. e})
end)

RegisterNetEvent('esx_status:onTick')
AddEventHandler('esx_status:onTick', function(status)
	SendNUIMessage({action = "updateStatus", status = status})
end)

AddEventHandler('onClientMapStart', function()
	if current == 0 then
		NetworkSetTalkerProximity(Config.VoiceDefaultProximity)
	elseif current == 1 then
		NetworkSetTalkerProximity(Config.VoiceShoutProximity)
	elseif current == 2 then
		NetworkSetTalkerProximity(Config.VoiceWhisperProximity)
	end
end)

