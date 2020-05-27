
exports['tp-stress']:AddStress('instant', 100000) -- Adds 100.000 (%10) stress instantly

exports['tp-stress']:AddStress('slow', 100000, 5) -- Adds 100.000 (%10) stress gradually in 5 seconds

exports['tp-stress']:RemoveStress('instant', 100000) -- Removes 100.000 (%10) stress instantly

exports['tp-stress']:RemoveStress('slow', 100000, 5) -- Removes 100.000 (%10) stress gradually in 5 seconds

Citizen.CreateThread(function()
    while true do -- döngü // loop
        local test = IsPedShooting(ped) -- kontrol etmek istediğiniz nativeler // native you want to check (natives: https://runtime.fivem.net/doc/natives/)
        if test then -- eğer native true dönerse alttaki olaylar yaşanacak // if the native returns true below action will happen
            TriggerServerEvent("stress:add", 500000) -- stres ekleme // adding stress
        else -- eğer native false dönerse bir şey yapmayıp döngü devam edecek // while the native returns false do nothing and keep the loop
            Citizen.Wait(1) -- nativeyi ne kadar sık kontrol etmek istediğinizi buraya yazın ms olarak (genelde 1000 altı olmalı) // how often you want to check the native in ms (should generally be smaller then 1000)
        end
    end
end)