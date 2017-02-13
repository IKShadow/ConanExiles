@echo off
setlocal EnableExtensions EnableDelayedExpansion
echo IKShadow's Show foundation spams
echo Lists of coords where players placed down only 1 foundation that does not having anything attached to it.
echo Run it from ConanSandbox\Saved\ (or change db path in source)
timeout 5
set db=game.db
sqlite3 %db% "SELECT actor_position.x, actor_position.y, actor_position.y, characters.char_name FROM buildings INNER JOIN building_instances ON buildings.object_id = building_instances.object_id INNER JOIN characters ON characters.id = buildings.owner_id INNER JOIN actor_position ON actor_position.id = buildings.object_id WHERE building_instances.class = '/Game/Systems/Building/BP_BuildFoundation.BP_BuildFoundation_C' GROUP BY characters.char_name HAVING COUNT(building_instances.object_id) <= 1;\" >results.txt
for /f "tokens=1,2,3,4 delims=| " %%a in (results.txt) do (
 set xc=%%a
 set yc=%%b
 set zc=%%c
 set owner=%%d
 echo TeleportPlayer !xc! !yc! !zc! Owner: !owner! >>output.txt
)
start notepad output.txt
timeout 1
del output.txt
del results.txt
exit
