function startUI(time, text) 
  SendNUIMessage({
    type = "ui",
    display = true,
    time = time,
    text = text
  })
end

function closeUI(...) 
  SendNUIMessage({
    type = "ui",
    display = false,
  })
end

RegisterCommand('sp', function(...) startUI(60 * 1000); end)
RegisterCommand('cp', function(...) closeUI(); end)