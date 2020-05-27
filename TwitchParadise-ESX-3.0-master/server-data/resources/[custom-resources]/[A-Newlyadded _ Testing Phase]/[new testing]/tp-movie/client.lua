local txd = CreateRuntimeTxd("duiTxd")
local duiObj = CreateDui("https://awwapp.com/b/utzickbpl/", 512, 256)
_G.duiObj = duiObj
local dui = GetDuiHandle(duiObj)
local tx = CreateRuntimeTextureFromDuiHandle(txd, "duiTex", dui)
--local tx = CreateRuntimeTextureFromImage(txd, "test", "images/test.png")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
         AddReplaceTexture("dt1_17_bb_meltdown", "dt1_17_cmk_billboard01", "duiTxd", "duiTex")
        --AddReplaceTexture("vehshare", "plate02", "testing", "test")
    end
end)


--(PROP, TEXTURENAME)