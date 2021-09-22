ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(5000)
    end
end)

function SavePlayerSkin()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
        TriggerServerEvent('jamsou:savechapeau', skin)
        TriggerServerEvent('jamsou:savelunettes', skin)
        TriggerServerEvent('jamsou:saveoreillette', skin)
        TriggerServerEvent('jamsou:savemasque', skin)
    end)
end

function SavePlayerSkinB()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end

JamsouTenue = true

-- Menu
local VetementPed = {
    Base = { Title = "Vêtements", Header = {"shopui_title_midfashion", "shopui_title_midfashion"}, Color = {color_black}, Blocked = true },
    Data = { currentMenu = "Articles disponible:" },
    Events = {
        onExited = function(self, _, btn, CMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide) 
			ClearPedTasks(PlayerPedId())
            TriggerEvent('skinchanger:modelLoaded')
            ESX.ShowColoredNotification('✅ Synchronisation effectuée.', 18)
        end,
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            -- locals
			local slide, btn, check, closestPlayer, closestDistance, playerPed, coords = btn.slidenum, btn.name, btn.unkCheckbox, ESX.Game.GetClosestPlayer(), PlayerPedId(), GetEntityCoords(playerPed)

            -- ifs
            if btn == "Modification du Ped" then
                OpenMenu('Modification du Ped')
            elseif btn == "Annuler" then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
                CloseMenu(true)
            elseif btn == "Payer" then
                SavePlayerSkin()
                TriggerServerEvent('jamsou:buycloth')
                ESX.ShowNotification("~r~Personnage~s~\nVous avez acheter des vêtements.")
                CloseMenu(true)
            end
        end,
        onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
            local currentMenu, currentBtn, slide, btn, ped = menuData.currentMenu, menuData.currentBtn, btn.slidenum, btn.name, GetPlayerPed(-1)

            -- ifs
            if btn == "Visage" and slide ~= -1 then
                visage = slide - 1
                SetPedComponentVariation(GetPlayerPed(-1), 0, visage, 0, 0)
            elseif btn == "Cheveux" and slide ~= -1 then
                cheveux = slide - 1
                TriggerEvent('skinchanger:change', 'hair_1', cheveux)
            elseif btn == "Haut" and slide ~= -1 then
                haut = slide - 1
                TriggerEvent('skinchanger:change', 'arms', haut)
            elseif btn == "Couleur Haut" and slide ~= -1 then
                couleurhaut = slide - 1
                TriggerEvent('skinchanger:change', 'arms_2', couleurhaut)
            elseif btn == "Pantalon" and slide ~= -1 then
                pantalon = slide - 1
                TriggerEvent('skinchanger:change', 'pants_1', pantalon)
            elseif btn == "Couleur Pantalon" and slide ~= -1 then
                couleurpantalon = slide - 1
                TriggerEvent('skinchanger:change', 'pants_2', couleurpantalon)
            elseif btn == "Lunettes" and slide ~= -1 then
                lunettes = slide - 1
                TriggerEvent('skinchanger:change', 'glasses_1', lunettes)
            elseif btn == "Couleur Lunettes" and slide ~= -1 then
                couleurlunettes = slide - 1
                TriggerEvent('skinchanger:change', 'glasses_2', couleurlunettes)
            elseif btn == "Chapeau" and slide ~= -1 then
                chapeau = slide - 1
                TriggerEvent('skinchanger:change', 'helmet_1', chapeau)
            elseif btn == "Couleur Chapeau" and slide ~= -1 then
                couleurchapeau = slide - 1
                TriggerEvent('skinchanger:change', 'helmet_2', couleurchapeau)
            end
        end
    },

    Menu = {
        ["Articles disponible:"] = {
            b = {
                {name = "Modification du Ped", ask = "→", askX = true},
                {name = "Vêtements", ask = "→", askX = true},
                {name = "Accessoires", ask = "→", askX = true},
                {name = "--------------------------------------------------------"},
                {name = "Payer", ask = "~g~$100", askX = true},
                {name = "Annuler"},
            }
        },
        ["Modification du Ped"] = {
            b = {
                {name = "Visage", slidemax = 3},
                {name = "Cheveux", slidemax = 2},
            }
        },
        ["vêtements"] = {
            b = {
                {name = "Haut", slidemax = 2},
                {name = "Couleur Haut", slidemax = 2},
                {name = "Pantalon", slidemax = 2},
                {name = "Couleur Pantalon", slidemax = 2},
            }
        },
        ["accessoires"] = {
            b = {
                {name = "Lunettes", slidemax = 1},
                {name = "Couleur Lunettes", slidemax = 2},
                {name = "Chapeau", slidemax = 1},
                {name = "Couleur Chapeau", slidemax = 2},
            }
        },
    }
}

local VetementNoPed = {
    Base = { Title = "Vêtements", Header = {"shopui_title_midfashion", "shopui_title_midfashion"}, Color = {color_black}, Blocked = true },
    Data = { currentMenu = "Articles disponible:" },
    Events = {
        onExited = function(self, _, btn, CMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide) 
			ClearPedTasks(PlayerPedId())
            TriggerEvent('skinchanger:modelLoaded')
            ESX.ShowColoredNotification('✅ Synchronisation effectuée.', 18)
        end,
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            -- locals
			local slide, btn, check, closestPlayer, closestDistance, playerPed, coords = btn.slidenum, btn.name, btn.unkCheckbox, ESX.Game.GetClosestPlayer(), PlayerPedId(), GetEntityCoords(playerPed)

            -- ifs
            if btn == "Annuler" then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
                CloseMenu(true)
            elseif btn == "Payer" then
                SavePlayerSkin()
                TriggerServerEvent('jamsou:buycloth')
                ESX.ShowNotification("~r~Personnage~s~\nVous avez acheter des vêtements.")
                CloseMenu(true)
            elseif btn == "Mode Manuel" then
                OpenMenu("Mode Manuel")
            end
        end,
        onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
            local currentMenu, currentBtn, slide, btn, ped = menuData.currentMenu, menuData.currentBtn, btn.slidenum, btn.name, GetPlayerPed(-1)

            -- ifs
            if btn == "T-Shirt" and slide ~= -1 then
                tshirt = slide - 1
                TriggerEvent('skinchanger:change', 'tshirt_1', tshirt)
            elseif btn == "Couleur T-Shirt" and slide ~= -1 then
                ctshirt = slide - 1
                TriggerEvent('skinchanger:change', 'tshirt_2', ctshirt)
            elseif btn == "Torse" and slide ~= -1 then
                torse = slide - 1
                TriggerEvent('skinchanger:change', 'torso_1', torse)
            elseif btn == "Couleur Torse" and slide ~= -1 then
                ctorse = slide - 1
                TriggerEvent('skinchanger:change', 'torso_2', ctorse)
            elseif btn == "Pantalon" and slide ~= -1 then
                pantalon = slide - 1
                TriggerEvent('skinchanger:change', 'pants_1', pantalon)
            elseif btn == "Couleur Pantalon" and slide ~= -1 then
                cpantalon = slide - 1
                TriggerEvent('skinchanger:change', 'pants_2', cpantalon)
            elseif btn == "Chaussures" and slide ~= -1 then
                chaussures = slide - 1
                TriggerEvent('skinchanger:change', 'shoes_1', chaussures)
            elseif btn == "Couleur Chaussures" and slide ~= -1 then
                cchaussures = slide - 1
                TriggerEvent('skinchanger:change', 'shoes_2', cchaussures)
            elseif btn == "Bras" and slide ~= -1 then
                bras = slide - 1
                TriggerEvent('skinchanger:change', 'arms', bras)
            elseif btn == "Couleur Bras" and slide ~= -1 then
                cbras = slide - 1
                TriggerEvent('skinchanger:change', 'arms_2', cbras)
            elseif btn == "Sac à dos" and slide ~= -1 then
                sac = slide - 1
                TriggerEvent('skinchanger:change', 'bags_1', sac)
            elseif btn == "Couleur Sac" and slide ~= -1 then
                csac = slide - 1
                TriggerEvent('skinchanger:change', 'bags_2', csac)
            elseif btn == "Montre" and slide ~= -1 then
                montre = slide - 1
                TriggerEvent('skinchanger:change', 'watches_1', montre)
            elseif btn == "Couleur Montre" and slide ~= -1 then
                cmontre = slide - 1
                TriggerEvent('skinchanger:change', 'watches_2', cmontre)
            elseif btn == "Chaîne" and slide ~= -1 then
                chaine = slide - 1
                TriggerEvent('skinchanger:change', 'chain_1', chaine)
            elseif btn == "Couleur Chaîne" and slide ~= -1 then
                cchaine = slide - 1
                TriggerEvent('skinchanger:change', 'chain_2', cchaine)
            elseif btn == "Bracelets" and slide ~= -1 then
                bracelets = slide - 1
                TriggerEvent('skinchanger:change', 'bracelets_1', bracelets)
            elseif btn == "Couleur Bracelets" and slide ~= -1 then
                cbracelets = slide - 1
                TriggerEvent('skinchanger:change', 'bracelets_2', cbracelets)
            elseif btn == "Chapeau" and slide ~= -1 then
                chapeau = slide - 1
                TriggerEvent('skinchanger:change', 'helmet_1', chapeau)
            elseif btn == "Couleur Chapeau" and slide ~= -1 then
                cchapeau = slide - 1
                TriggerEvent('skinchanger:change', 'helmet_2', cchapeau)
            elseif btn == "Lunettes" and slide ~= -1 then
                lunettes = slide - 1
                TriggerEvent('skinchanger:change', 'glasses_1', lunettes)
            elseif btn == "Couleur Lunettes" and slide ~= -1 then
                clunettes = slide - 1
                TriggerEvent('skinchanger:change', 'glasses_2', clunettes)
            elseif btn == "Oreillette" and slide ~= -1 then
                oreillette = slide - 1
                TriggerEvent('skinchanger:change', 'ears_1', oreillette)
            elseif btn == "Couleur Oreillette" and slide ~= -1 then
                coreillette = slide - 1
                TriggerEvent('skinchanger:change', 'ears_2', coreillette)
            end
        end
    },

    Menu = {
        ["Articles disponible:"] = {
            b = {
                {name = "Vêtements", ask = "→", askX = true},
                {name = "Accessoires", ask = "→", askX = true},
                {name = "Mode Manuel", ask = "→", askX = true},
                {name = "--------------------------------------------------------"},
                {name = "Payer", ask = "~g~$100", askX = true},
                {name = "Annuler"},
            }
        },
        ["vêtements"] = {
            b = {
                {name = "T-Shirt", slidemax = 143},
                {name = "Couleur T-Shirt", slidemax = 21},
                {name = "Torse", slidemax = 289},
                {name = "Couleur Torse", slidemax = 21},
                {name = "Pantalon", slidemax = 114},
                {name = "Couleur Pantalon", slidemax = 21},
                {name = "Chaussures", slidemax = 90},
                {name = "Couleur Chaussures", slidemax = 21},
            }
        },
        ["accessoires"] = {
            b = {
                {name = "Chapeau", slidemax = 134},
                {name = "Couleur Chapeau", slidemax = 15},
                {name = "Lunettes", slidemax = 27},
                {name = "Couleur Lunettes", slidemax = 15},
                {name = "Oreillette", slidemax = 27},
                {name = "Couleur Oreillette", slidemax = 10},
                {name = "--------------------------------------------------------"},
                {name = "Autre", ask = "→", askX = true},
            }
        },
        ["Mode Manuel"] = {
            b = {
                {name = "Sac à dos", slidemax = 80},
                {name = "Couleur Sac", slidemax = 25},
                {name = "Bras", slidemax = 167},
                {name = "Couleur Bras", slidemax = 15},
            }
        },
        ["autre"] = {
            b = {
                {name = "Montre", slidemax = 29},
                {name = "Couleur Montre", slidemax = 10},
                {name = "Chaîne", slidemax = 131},
                {name = "Couleur Chaîne", slidemax = 15},
                {name = "Bracelets", slidemax = 7},
                {name = "Couleur Bracelets", slidemax = 5},
            }
        },
    }
}

local BarberNoPed = {
    Base = { Title = "Coiffeur", Header = {"shopui_title_barber4", "shopui_title_barber4"}, Color = {color_black}, Blocked = true },
    Data = { currentMenu = "Options disponible:" },
    Events = {
        onExited = function(self, _, btn, CMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide) 
			ClearPedTasks(PlayerPedId())
            TriggerEvent('skinchanger:modelLoaded')
            ESX.ShowColoredNotification('✅ Synchronisation effectuée.', 18)
        end,
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            -- locals
			local slide, btn, check, closestPlayer, closestDistance, playerPed, coords = btn.slidenum, btn.name, btn.unkCheckbox, ESX.Game.GetClosestPlayer(), PlayerPedId(), GetEntityCoords(playerPed)

            -- ifs
            if btn == "Annuler" then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
                CloseMenu(true)
            elseif btn == "Payer" then
                SavePlayerSkinB()
                TriggerServerEvent('jamsou:buycloth')
                ESX.ShowNotification("~r~Personnage~s~\nVous avez acheter des vêtements.")
                CloseMenu(true)
            end
        end,
        onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
            local currentMenu, currentBtn, slide, btn, ped = menuData.currentMenu, menuData.currentBtn, btn.slidenum, btn.name, GetPlayerPed(-1)

            -- ifs
            if btn == "Coupes" and slide ~= -1 then
                coupe = slide - 1
                TriggerEvent('skinchanger:change', 'hair_1', coupe)
            elseif btn == "Teinture" and slide ~= -1 then
                teinture1 = slide - 1
                TriggerEvent('skinchanger:change', 'hair_color_1', teinture1)
            elseif btn == "Barbes" and slide ~= -1 then
                barbe = slide - 1
                TriggerEvent('skinchanger:change', 'beard_1', barbe)
            elseif btn == "Taille" and slide ~= -1 then
                tbarbe = slide - 1
                TriggerEvent('skinchanger:change', 'beard_2', tbarbe)
            elseif btn == "Teinture " and slide ~= -1 then
                teinture1b = slide - 1
                TriggerEvent('skinchanger:change', 'beard_3', teinture1b)
            elseif btn == "Maquillage " and slide ~= -1 then
                maquillage = slide - 1
                TriggerEvent('skinchanger:change', 'makeup_1', maquillage)
            elseif btn == "Taille " and slide ~= -1 then
                tmaquillage = slide - 1
                TriggerEvent('skinchanger:change', 'makeup_2', tmaquillage)
            elseif btn == "Couleur" and slide ~= -1 then
                cmaquillage = slide - 1
                TriggerEvent('skinchanger:change', 'makeup_4', cmaquillage)
            end
        end
    },

    Menu = {
        ["Options disponible:"] = {
            b = {
                {name = "Cheveux", ask = "→", askX = true},
                {name = "Barbe", ask = "→", askX = true},
                {name = "Maquillage", ask = "→", askX = true},
                {name = "--------------------------------------------------------"},
                {name = "Payer", ask = "~g~$100", askX = true},
                {name = "Annuler"},
            }
        },
        ["cheveux"] = {
            b = {
                {name = "Coupes", slidemax = 73},
                {name = "Teinture", slidemax = 63},
            }
        },
        ["barbe"] = {
            b = {
                {name = "Barbes", slidemax = 28},
                {name = "Taille", slidemax = 10},
                {name = "Teinture ", slidemax = 63},
            }
        },
        ["maquillage"] = {
            b = {
                {name = "Maquillage ", slidemax = 71},
                {name = "Taille ", slidemax = 10},
                {name = "Couleur", slidemax = 63},
            }
        },
    }
}

local vetementspoz = {
    {x = -1193.16, y = -767.98, z = 17.32},
    {x = -822.42, y = -1073.55, z = 11.33},
    {x = 75.34, y = -1393.00, z = 29.38},
    {x = -709.86, y = -153.1, z = 37.42},
    {x = -163.37, y = -302.73, z = 39.73},
    {x = 425.59, y = -806.15, z = 29.49},
    {x = -1450.42, y = -237.66, z = 49.81},
    {x = 4.87, y = 6512.46, z = 31.88},
    {x = 125.77, y = -223.9, z = 54.56},
    {x = 1693.92, y = 4822.82, z = 42.06},
    {x = 614.19, y = 2762.79, z = 42.09},
    {x = 1196.61, y = 2710.25, z = 38.22},
    {x = -3170.54, y = 1043.68, z = 20.86},
    {x = -1101.48, y = 2710.57, z = 19.11}
}

local barberpoz = {
    {x = -814.3, y = -183.8, z = 36.6},
    {x = 136.8, y = -1708.4, z = 28.3},
    {x = -1282.6, y = -1116.8, z = 6.0},
    {x = 1931.5, y = 3729.7, z = 31.8},
    {x = 1212.8, y = -472.9, z = 65.2},
    {x = -32.9, y = -152.3, z = 56.1},
    {x = -278.1, y = 6228.5, z = 30.7}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k, v in pairs(vetementspoz) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, vetementspoz[k].x, vetementspoz[k].y, vetementspoz[k].z)

            if dist <= 2.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~magasin de vêtements~w~.")
                if IsControlJustPressed(1,51) then 	
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        if skin.sex > 1 then
                            CreateMenu(VetementPed)
                        else
                            CreateMenu(VetementNoPed)
                        end
                    end)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k, v in pairs(barberpoz) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, barberpoz[k].x, barberpoz[k].y, barberpoz[k].z)

            if dist <= 2.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~coiffueur~w~.")
                if IsControlJustPressed(1,51) then 	
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        if skin.sex > 1 then
                            ESX.ShowNotification("~r~Impossible.~s~\nRendez-vous dans un magasin de vêtements pour changer vos cheveux.")
                        else
                            CreateMenu(BarberNoPed)
                        end
                    end)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	for _, pos in pairs(vetementspoz) do
		blips = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(blips, 73)
		SetBlipScale(blips, 0.6)
		SetBlipDisplay(blips, 4)
		SetBlipColour(blips, 81)
		SetBlipAsShortRange(blips, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Magasins de vêtements")
		EndTextCommandSetBlipName(blips)
	end
end)

Citizen.CreateThread(function()
	for _, pos in pairs(barberpoz) do
		blips = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(blips, 71)
		SetBlipScale(blips, 0.6)
		SetBlipDisplay(blips, 4)
		SetBlipColour(blips, 81)
		SetBlipAsShortRange(blips, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coiffeurs")
		EndTextCommandSetBlipName(blips)
	end
end)