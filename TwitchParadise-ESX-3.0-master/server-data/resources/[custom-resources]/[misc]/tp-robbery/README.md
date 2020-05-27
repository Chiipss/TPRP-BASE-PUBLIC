# Requirements
- ESX
- cron
- lockpicking
- vSync
  * Not required. Can use alternative.
  * If using vSync, use the one provided. It has events added that are needed for this script.
  * If you don't use vSync, prepare to change some functions and variables.
  * You need to stop weather and time syncing while inside apartments, otherwise there are terrible shadow effects.
- mythic_interiors 
  * Suggest using a fork that loads shells properly before teleporting player inside (and for complete deletion of interior objects spawned).
  * If you don't want to use mythic_interiors, you'll have to use/make a different "shell loader".
  * If you use a different loader, be prepared to change some function and var names.

# Installation
1. Drag and drop folder into resources directory.
2. We recommend changing the folder name.
  * Consider also renaming files.
3. Make sure you check the config.lua and replace the "receipt" var with your receipt number.
4. Start the resource in server.cfg
5. If sql file included, import it to your database.
6. Re-check step 3. Make sure you done it.
7. Wait for authentication from our server before trying to use.
