local bossUI = {x=-1876.2971191406,y=2062.4099121094,z=145.57377624512}

ESX                             = nil
local PlayerData 				= nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
    PlayerData = ESX.PlayerData
  end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
--[[ 	local specialContact = {
		name       = 'lawyer',
		number     = 'lawyer',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAA3QAAAN0BcFOiBwAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAARoSURBVFiF7Zd/aFVlGMc/z3vPvfvldNPmnEbUyoUUQUVumJqDCaXYsrnb8ge2Zvnjj/4JzJxwJxJaUUQgDpoRFCZHmjpDxGg0HFjSHzENHa7wV/4cabft3uu955y3P+7uZXc7pzsHsX964IX3vO/zfL/f53nP+573iNaaiTQ1oeyAMe7INinFporTD1aSZ+/jw0tnxgMzvgq0yuvY/A4c4uL0dzlfeppND38+HigZ/Q6I4sKigGdE149zicU6AR8A385NIcEjtzbyxINfeMZeXBQnFHKGD42qwMm24G6tB6Lg0UoKu9Lkw00LJAr2YEnUremERPf3/7R7ZFiGgAPBoO/a5aL6qxeLrwC9ri1yd8Azw6hYXnG9t/xX+vr99cFgMEN8xkuoKqYucRymnfy+vH3FjtY6V5Jj8h7CVtc5iZ1iXeezblP7g7XfAC/PkfgS4Eiac7iTFr1uqLvs6+Y3Sl1JcviEnBxn9LgFUyJNbiHNK2tLBZYBiE5zZApob15fBrJ06NHvF2Otq4BVq0p44XlF2QxQCpSGskF4KwFbHp/tFhJIsFaDH0BgaXNdXdkoAY7QCPgQDgKI0q7ZYMtiJhfC4hpY2QAfObA1Dx7IgYTV6BaihaYh8oMafAEjkfZLChARkCYA7fNtBrq1pqJ924aFo+GkJt1VCgwZxmTNG+m9/ZXahUAF0A1sBtBamkRE0gIObNtQjVAO0lUf2t2nRfYmlWeuF1QboJ9zrQyAFZvOhercEemvS2av94bMw30CXUB5S/2y6rQAIUkkotsA8nyOCYQ1suLQ9saiNFh0ViVQ6CnAcYR8/2vp7JcvLwK9AggTwyRJ1pYhbMerL71dMm3SLjSJG/0D72jtJACmFResDPiNBdFofH9/ONqywzzcS2xNCE1LBumNc5kicgt/YEZnde38Zx69Lz+vJd8faEjY1ombA+F9AKKUf2bhlPcB//WBv7cYtq13XrsRNkieCZ+mcPr/HEx1GwzkCNCLpoZsZsWfAjBEP307Mthwm0GABSALALSj+eOvO0PFYKdC656soMrqgeAkoGoMAiYzWFOqHcmKq6FHgXRk8ev71ck/SySwiDF9vjUMssmY9dBZgb5/95UOBYFdgJdaS9CNpmnaiGQvfzrKftE0TVuLNAKWh1ePcSe2S4VMMx69y3w0rUAEQECDPiVKV4bMju6kWD12AXZ8DkD7iZ+7RUklok8Bqe9+BKTVJm++eeZMPOM+EAwGfY85sdnkWldDXx0Npycia8oQrrqSjdwFKSsofpKS47+kHpdUVU3OV9ZMdX/5edM07dS4y4XExWKrV6Ply3sSkFvUyozvNmaDHtuVzLmH9U+ZnVg8FjfPChz9+M0K29JTAebVxTuUosTN7+a5yx7IyunuLF4PYPi4tHbngeNubp7bStt8ICK1ACfbczwzOPub32tKQfgzgPzcnOtAmYfTxNr/AiZcgPfZ7rAH4Vg2gKJJBS63pkzzKZ/nb9vYDqL/0CZ8Cf4BrBmoU1KcpzcAAAAASUVORK5CYII='
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon) ]]
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer

  if(PlayerData.job.grade_name == "boss" and PlayerData.job.name == "lswc") then
  	createSocietyMenu(bossUI.x,bossUI.y,bossUI.z,"lswc", "Los Santos Wine Co")
  end
  
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job

  if(PlayerData.job.grade_name == "boss" and PlayerData.job.name == "lswc") then
  	createSocietyMenu(bossUI.x,bossUI.y,bossUI.z,"society_lswc", "Los Santos Wine Co")
  end

end)

function Info(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end

local hint = '[E] LS Wine Co Menu'


function DrawM(hint, type, x, y, z)
	Draw3DText(x, y, z + 1.2, hint)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function createSocietyMenu(x,y,z,name, menuName)
    Citizen.CreateThread(function()
        local menuShowed = false
        while true do
            Citizen.Wait(0)
            local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),x,y,z, true)
            
            if(distance > 2 and menuShowed) then
                ESX.UI.Menu.CloseAll()
            end

            if(distance<2.5) then
                DrawM('[E] Open LS Wine Co Menu', 27, x, y, z - 0.945, 255, 255, 255, 1.5, 15)

                if(IsControlJustPressed(1, 38)) then
                    menuShowed = not menuShowed

                    if(menuShowed) then
                        --print(name)
                        renderMenu(name, menuName)
                    else
                        ESX.UI.Menu.CloseAll()
                    end
                end
            end
        end
    end)
end

function renderMenu(name, menuName)
	local _name = name
	local elements = {}
	
	table.insert(elements, {label = 'Boss actions', value = 'boss_menu'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lswc',
		{
			title    = menuName,
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'boss_menu' then
				TriggerEvent('esx_society:openBossMenu', 'lswc', function(data, menu)
					menu.close()
				end
			)
		end

		end,
		function(data, menu)

			menu.close()
		end
	)
end