ESX = nil
Citizen.CreateThread(function()
    while true do
        Wait(5)
        if ESX ~= nil then
       
        else
            ESX = nil
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end
    end
end)
 
local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
 
rootMenuConfig =  {
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
        fuck = exports["ambulancejob"]:GetDeath()
            return not fuck
        end,
        subMenus = {"general:flipvehicle",  "general:checkoverself", "general:checktargetstates",  "general:keysgive",  "general:emotes",  "general:checkvehicle", "general:apartgivekey", "general:aparttakekey"  }
    },
    {
        id = "police-action",
        displayName = "Police Actions",
        icon = "#police-action",
        enableMenu = function()
           local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["ambulancejob"]:GetDeath()
            if PlayerData.job.name == "police" and not fuck then
                return true
            end
        end,
        subMenus = {"cuffs:cuff", "cuffs:softcuff", "cuffs:uncuff", "police:escort", "police:putinvehicle", "police:unseatnearest", "cuffs:checkinventory", --[[ "cuffs:remmask",  "police:frisk", ]]--[[ "police:removeweapons" ]] "police:revive", "police:gsr", "police:openmdt", "police:getid", "police:impound", "police:spikes"}
    },
    {
        id = "police-vehicle",
        displayName = "Police Vehicle",
        icon = "#police-vehicle",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["ambulancejob"]:GetDeath()
            if PlayerData.job.name == "police" and not fuck and IsPedInAnyVehicle(PlayerPedId(), false) then
                return true
            end
        end,
        subMenus = {--[[ "general:unseatnearest", ]] "police:runplate", --[[ "police:toggleradar" ]]}
    },
    {
        id = "policeDead",
        displayName = "10-13",
        icon = "#police-dead",
        functionName = "tp:panicTrigger",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["ambulancejob"]:GetDeath()
            if PlayerData.job.name == "police" and fuck then
                return true
            end
        end,
    },
    {
        id = "emsDead",
        displayName = "10-14",
        icon = "#ems-dead",
        functionName = "tp:panicTriggerMedic",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["ambulancejob"]:GetDeath()
            if PlayerData.job.name == "ambulance" and fuck then
                return true
            end
        end,
    },
    {
        id = "k9",
        displayName = "K9",
        icon = "#k9",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["ambulancejob"]:GetDeath()
            if PlayerData.job.name == "police" and not fuck then
                return true
            end
        end,
        subMenus = {"k9:follow", "k9:vehicle",  --[[ "k9:sniffvehicle", ]] --[[ "k9:huntfind", ]] "k9:sit", "k9:stand", "k9:sniff", "k9:lay",  "k9:spawn", "k9:delete", }
    },
    {
        id = "animations",
        displayName = "Walking Styles",
        icon = "#walking",
        enableMenu = function()
        fuck = exports["ambulancejob"]:GetDeath()
            return not fuck
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },
    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
        fuck = exports["ambulancejob"]:GetDeath()
            return not fuck
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    {
        id = "judge-raid",
        displayName = "Judge Raid",
        icon = "#judge-raid",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "judge-raid:checkowner", "judge-raid:seizeall", "judge-raid:takecash", "judge-raid:takedm"}
    },
    {
        id = "judge-licenses",
        displayName = "Judge Licenses",
        icon = "#judge-licenses",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:checklicenses", "judge:grantDriver", "judge:grantBusiness", "judge:grantWeapon", "judge:grantHouse", "judge:grantBar", "judge:grantDA", "judge:removeDriver", "judge:removeBusiness", "judge:removeWeapon", "judge:removeHouse", "judge:removeBar", "judge:removeDA", "judge:denyWeapon", "judge:denyDriver", "judge:denyBusiness", "judge:denyHouse" }
    },
--[[     {
        id = "judge-actions",
        displayName = "Judge Actions",
        icon = "#judge-actions",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:cuff", "cuffs:uncuff", "general:escort", "police:frisk", "cuffs:checkinventory", "police:checkbank"}
    }, ]]
    {
        id = "judge-actions",
        displayName = "Mechanic Actions",
        icon = "#police-vehicle",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["ambulancejob"]:GetDeath()
            if PlayerData.job.name == "mechanic" and not fuck then
                return true
            end
        end,
        subMenus = { "mechanic:hijack", "mechanic:repair", "mechanic:clean", "mechanic:impound"}
    },
    {
        id = "medic",
        displayName = "Medical",
        icon = "#medic",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["ambulancejob"]:GetDeath()
            if PlayerData.job.name == "ambulance" and not fuck then
                return true
            end
        end,
        subMenus = {"medic:revive", "medic:heal", "medic:bigheal", "medic:drag", "medic:undrag", "medic:putinvehicle", "medic:takeoutvehicle", }
    },
    {
        id = "doctor",
        displayName = "Doctor",
        icon = "#doctor",
        enableMenu = function()
            return (not isDead and isDoctor)
        end,
        subMenus = { "general:escort", "medic:revive", "general:checktargetstates", "medic:heal" }
    },
    {
        id = "news",
        displayName = "News",
        icon = "#news",
        enableMenu = function()
            return (not isDead and isNews)
        end,
        subMenus = { "news:setCamera", "news:setMicrophone", "news:setBoom" }
    },
--[[     {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options-vehicle",
        functionName = "veh:options",
        enableMenu = function()
        fuck = exports["ambulancejob"]:GetDeath()
            if not fuck and IsPedInAnyVehicle(PlayerPedId(), false) then
                return true
            end
        end,
    }, ]]
    {
        id = "impound",
        displayName = "Impound Vehicle",
        icon = "#impound-vehicle",
        functionName = "impoundVehicle",
        enableMenu = function()
        fuck = exports["ambulancejob"]:GetDeath()
            if not fuck and myJob == "towtruck" and #(GetEntityCoords(PlayerPedId()) - vector3(549.47796630859, -55.197559356689, 71.069190979004)) < 10.599 then
                return true
            end
            return false
        end
    }, {
        id = "oxygentank",
        displayName = "Remove Oxygen Tank",
        icon = "#oxygen-mask",
        functionName = "RemoveOxyTank",
        enableMenu = function()
        fuck = exports["ambulancejob"]:GetDeath()
            return not fuck and hasOxygenTankOn
        end
    }, {
        id = "cocaine-status",
        displayName = "Request Status",
        icon = "#cocaine-status",
        functionName = "cocaine:currentStatusServer",
        enableMenu = function()
        fuck = exports["ambulancejob"]:GetDeath()
            if not fuck and gangNum == 2 and #(GetEntityCoords(PlayerPedId()) - vector3(1087.3937988281,-3194.2138671875,-38.993473052979)) < 0.5 then
                return true
            end
            return false
        end
    }, {
        id = "cocaine-crate",
        displayName = "Remove Crate",
        icon = "#cocaine-crate",
        functionName = "cocaine:methCrate",
        enableMenu = function()
        fuck = exports["ambulancejob"]:GetDeath()
            if not fuck and gangNum == 2 and #(GetEntityCoords(PlayerPedId()) - vector3(1087.3937988281,-3194.2138671875,-38.993473052979)) < 0.5 then
                return true
            end
            return false
        end
    }
}

newSubMenus = {
    ['general:emotes'] = {
        title = "Emotes",
        icon = "#general-emotes",
        functionName = "dp:RecieveMenu"
    },    
    ['general:keysgive'] = {
        title = "Give Key",
        icon = "#general-keys-give",
        functionName = "tp:givekey"
    },
    ['general:apartgivekey'] = {
        title = "Give Key",
        icon = "#general-apart-givekey",
        functionName = "menu:givekeys"
    },
    ['general:aparttakekey'] = {
        title = "Take Key",
        icon = "#general-apart-givekey",
        functionName = "menu:takekeys"
    },
--[[     ['general:checkoverself'] = {
        title = "Examine Self",
        icon = "#general-check-over-self",
        functionName = "Evidence:CurrentDamageList"
    },
    ['general:checktargetstates'] = {
        title = "Examine Target",
        icon = "#general-check-over-target",
        functionName = "requestWounds"
    }, ]]
--[[     ['general:checkvehicle'] = {
        title = "Examine Vehicle",
        icon = "#general-check-vehicle",
        functionName = "towgarage:annoyedBouce"
    }, ]]
    ['general:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:forceEnter"
    },
    ['general:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "unseatPlayer"
    },    
    ['general:flipvehicle'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Man Eater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['mechanic:hijack'] = {
        title = "Hijack",
        icon = "#police-vehicle",
        functionName = "tp:hijack"
    },
    ['mechanic:repair'] = {
        title = "Repair",
        icon = "#police-vehicle",
        functionName = "tp:mechrepair"
    },
    ['mechanic:clean'] = {
        title = "Clean",
        icon = "#police-vehicle",
        functionName = "tp:mechclean"
    },
    ['mechanic:impound'] = {
        title = "Impound",
        icon = "#police-vehicle",
        functionName = "tp:mechimpound"
    },
    ['k9:spawn'] = {
        title = "Summon",
        icon = "#k9-spawn",
        functionName = "K9:Create"
    },
    ['k9:delete'] = {
        title = "Dismiss",
        icon = "#k9-dismiss",
        functionName = "K9:Delete"
    },
    ['k9:follow'] = {
        title = "Follow",
        icon = "#k9-follow",
        functionName = "K9:Follow"
    },
    ['k9:vehicle'] = {
        title = "Get in/out",
        icon = "#k9-vehicle",
        functionName = "K9:Vehicle"
    },
    ['k9:sit'] = {
        title = "Sit",
        icon = "#k9-sit",
        functionName = "K9:Sit"
    },
    ['k9:lay'] = {
        title = "Lay",
        icon = "#k9-lay",
        functionName = "K9:Lay"
    },
    ['k9:stand'] = {
        title = "Stand",
        icon = "#k9-stand",
        functionName = "K9:Stand"
    },
    ['k9:sniff'] = {
        title = "Sniff Person",
        icon = "#k9-sniff",
        functionName = "tp:k9drugsniff"
    },
--[[     ['k9:sniffvehicle'] = {
        title = "Sniff Vehicle",
        icon = "#k9-sniff-vehicle",
        functionName = "sniffVehicle"
    }, ]]
--[[     ['k9:huntfind'] = {
        title = "Hunt nearest",
        icon = "#k9-huntfind",
        functionName = "K9:Huntfind"
    }, ]]
--[[     ['judge-raid:checkowner'] = {
        title = "Check Owner",
        icon = "#judge-raid-check-owner",
        functionName = "appartment:CheckOwner"
    },
    ['judge-raid:seizeall'] = {
        title = "Seize All Content",
        icon = "#judge-raid-seize-all",
        functionName = "appartment:SeizeAll"
    },
    ['judge-raid:takecash'] = {
        title = "Take Cash",
        icon = "#judge-raid-take-cash",
        functionName = "appartment:TakeCash"
    },
    ['judge-raid:takedm'] = {
        title = "Take Marked Bills",
        icon = "#judge-raid-take-dm",
        functionName = "appartment:TakeDM"
    }, ]]
    ['cuffs:cuff'] = {
        title = "Hard Cuff",
        icon = "#cuffs-cuff",
        functionName = "tp:handcuff"
    }, 
    ['cuffs:softcuff'] = {
        title = "Soft Cuff",
        icon = "#cuffs-cuff",
        functionName = "tp:softcuff"
    },
    ['cuffs:uncuff'] = {
        title = "Uncuff",
        icon = "#cuffs-uncuff",
        functionName = "tp:uncuff"
    },
--[[     ['cuffs:remmask'] = {
        title = "Remove Mask Hat",
        icon = "#cuffs-remove-mask",
        functionName = "police:remmask"
    }, ]]
    ['cuffs:checkinventory'] = {
        title = "Search Person",
        icon = "#cuffs-check-inventory",
        functionName = "tp:search"
    },
    ['cuffs:unseat'] = {
        title = "Unseat",
        icon = "#cuffs-unseat-player",
        functionName = "esx_ambulancejob:pullOutVehicle"
    },
    ['cuffs:checkphone'] = {
        title = "Read Phone",
        icon = "#cuffs-check-phone",
        functionName = "police:checkPhone"
    },
    ['medic:revive'] = {
        title = "Revive",
        icon = "#medic-revive",
        functionName = "tp:emsRevive"
    },
    ['medic:heal'] = {
        title = "Treat Small Wounds",
        icon = "#medic-heal",
        functionName = "tp:emssmallheal"
    },
    ['medic:bigheal'] = {
        title = "Treat Serious Wounds",
        icon = "#medic-heal",
        functionName = "tp:emsbigheal"
    },
    ['medic:putinvehicle'] = {
        title = "Put in vehicle",
        icon = "#general-put-in-veh",
        functionName = "tp:emsputinvehicle"
    },
    ['medic:takeoutvehicle'] = {
        title = "Take out vehicle",
        icon = "#general-unseat-nearest",
        functionName = "tp:emstakeoutvehicle"
    },
    ['medic:drag'] = {
        title = "Drag",
        icon = "#general-escort",
        functionName = "tp:emsdrag"
    },
    ['medic:undrag'] = {
        title = "Undrag",
        icon = "#general-escort",
        functionName = "tp:emsundrag"
    },
    ['police:spikes'] = {
        title = "Deploy Spikes",
        icon = "#k9-spawn",
        functionName = "c_setSpike"
    },
    ['police:escort'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "tp:escort"
    },
    ['police:revive'] = {
        title = "Revive",
        icon = "#medic-revive",
        functionName = "tp:pdrevive"
    },
    ['police:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "tp:putinvehicle"
    },
    ['police:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "tp:takeoutvehicle"
    },
    ['police:impound'] = {
        title = "Impound",
        icon = "#police-vehicle",
        functionName = "tp:menuimpound"
    },
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:cuffFromMenu"
    },
    ['police:checkbank'] = {
        title = "Check Bank",
        icon = "#police-check-bank",
        functionName = "police:checkBank"
    },
    ['police:checklicenses'] = {
        title = "Check Licenses",
        icon = "#police-check-licenses",
        functionName = "police:checkLicenses"
    },
--[[     ['police:removeweapons'] = {
        title = "Remove Weapons License",
        icon = "#police-action-remove-weapons",
        functionName = "police:removeWeapon"
    }, ]]
    ['police:gsr'] = {
        title = "GSR Test",
        icon = "#police-action-gsr",
        functionName = "tp:checkGSR"
    },
    ['police:openmdt'] = {
        title = "MDT",
        icon = "#judge-licenses-grant-business",
        functionName = "tp:openmdt"
    },
    ['police:getid'] = {
        title = "Get ID",
        icon = "#police-vehicle-plate",
        functionName = "tp:getid"
    },
--[[     ['police:toggleradar'] = {
        title = "Toggle Radar",
        icon = "#police-vehicle-radar",
        functionName = "startSpeedo"
    }, ]]
    ['police:runplate'] = {
        title = "Run Plate",
        icon = "#police-vehicle-plate",
        functionName = "tp:mdtvehiclesearch"
    },
--[[     ['police:frisk'] = {
        title = "Frisk",
        icon = "#police-action-frisk",
        functionName = "police:frisk"
    }, ]]
    ['judge:grantDriver'] = {
        title = "Grant Drivers",
        icon = "#judge-licenses-grant-drivers",
        functionName = "police:grantDriver"
    }, 
    ['judge:grantBusiness'] = {
        title = "Grant Business",
        icon = "#judge-licenses-grant-business",
        functionName = "police:grantBusiness"
    },  
    ['judge:grantWeapon'] = {
        title = "Grant Weapon",
        icon = "#judge-licenses-grant-weapon",
        functionName = "police:grantWeapon"
    },
    ['judge:grantHouse'] = {
        title = "Grant House",
        icon = "#judge-licenses-grant-house",
        functionName = "police:grantHouse"
    },
    ['judge:grantBar'] = {
        title = "Grant BAR",
        icon = "#judge-licenses-grant-bar",
        functionName = "police:grantBar"
    },
    ['judge:grantDA'] = {
        title = "Grant DA",
        icon = "#judge-licenses-grant-da",
        functionName = "police:grantDA"
    },
    ['judge:removeDriver'] = {
        title = "Remove Drivers",
        icon = "#judge-licenses-remove-drivers",
        functionName = "police:removeDriver"
    },
    ['judge:removeBusiness'] = {
        title = "Remove Business",
        icon = "#judge-licenses-remove-business",
        functionName = "police:removeBusiness"
    },
    ['judge:removeWeapon'] = {
        title = "Remove Weapon",
        icon = "#judge-licenses-remove-weapon",
        functionName = "police:removeWeapon"
    },
    ['judge:removeHouse'] = {
        title = "Remove House",
        icon = "#judge-licenses-remove-house",
        functionName = "police:removeHouse"
    },
    ['judge:removeBar'] = {
        title = "Remove BAR",
        icon = "#judge-licenses-remove-bar",
        functionName = "police:removeBar"
    },
    ['judge:removeDA'] = {
        title = "Remove DA",
        icon = "#judge-licenses-remove-da",
        functionName = "police:removeDA"
    },
    ['judge:denyWeapon'] = {
        title = "Deny Weapon",
        icon = "#judge-licenses-deny-weapon",
        functionName = "police:denyWeapon"
    },
    ['judge:denyDriver'] = {
        title = "Deny Drivers",
        icon = "#judge-licenses-deny-drivers",
        functionName = "police:denyDriver"
    },
    ['judge:denyBusiness'] = {
        title = "Deny Business",
        icon = "#judge-licenses-deny-business",
        functionName = "police:denyBusiness"
    },
    ['judge:denyHouse'] = {
        title = "Deny House",
        icon = "#judge-licenses-deny-house",
        functionName = "police:denyHouse"
    },
    ['news:setCamera'] = {
        title = "Camera",
        icon = "#news-job-news-camera",
        functionName = "camera:setCamera"
    },
    ['news:setMicrophone'] = {
        title = "Microphone",
        icon = "#news-job-news-microphone",
        functionName = "camera:setMic"
    },
    ['news:setBoom'] = {
        title = "Microphone Boom",
        icon = "#news-job-news-boom",
        functionName = "camera:setBoom"
    },
    ['weed:currentStatusServer'] = {
        title = "Request Status",
        icon = "#weed-cultivation-request-status",
        functionName = "weed:currentStatusServer"
    },   
    ['weed:weedCrate'] = {
        title = "Remove A Crate",
        icon = "#weed-cultivation-remove-a-crate",
        functionName = "weed:weedCrate"
    },
    ['cocaine:currentStatusServer'] = {
        title = "Request Status",
        icon = "#meth-manufacturing-request-status",
        functionName = "cocaine:currentStatusServer"
    },
    ['cocaine:methCrate'] = {
        title = "Remove A Crate",
        icon = "#meth-manufacturing-remove-a-crate",
        functionName = "cocaine:methCrate"
    },
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="One Eye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    }
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end
