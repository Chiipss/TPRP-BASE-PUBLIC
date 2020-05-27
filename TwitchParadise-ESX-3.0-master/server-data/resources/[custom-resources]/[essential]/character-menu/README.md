# KASHacters - ESX Multi Characters

## Introduction

> I only rework the design of the script and added a few new displays in character selection

## Installation

> First of all to get this working you need to comment out the `NetworkIsSessionStarted()` Citizen.CreateThread() in *essentialmode\client\main.lua* on line *6 - 16*

>Second you need to upload the SQL file to your database **BEFORE** you start the resource.

>At last you will put the resource (*esx_kashacters*) in your resource folder.

>In the *esx_kashacters\server\main.lua* you can edit the tables where an identifier is needed as such:
```
local IdentifierTables = {
    {table = "users", column = "identifier"},
    {table = "owned_vehicles", column = "owner"},
    {table = "user_accounts", column = "identifier"},
}
```

