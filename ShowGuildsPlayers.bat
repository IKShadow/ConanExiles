@echo off
set db=game.db
echo IKShadow's Guild list
echo Run it from ConanSandbox\Saved\ (or change path in source)
echo FORMAT: Guild Player Level 
timeout 3
sqlite3 %db% "SELECT guilds.name AS Guild, characters.char_name AS Player, characters.level AS Level FROM characters INNER JOIN guilds ON characters.guild=guilds.guildId Order by guilds.name;" >>guilds.txt
start notepad "guilds.txt"
timeout 1
del guilds.txt
exit
