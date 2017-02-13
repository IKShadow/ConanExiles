@echo off
setlocal EnableExtensions EnableDelayedExpansion
echo IKShadow's Structure list at X/Y/R
echo Run it from ConanSandbox\Saved\ (or change db path in source)
echo Output wil be open in notepad with TeleportPlayer X Y Y + structure class 
set /p x="Enter X coord: "
set /p y="Enter Y coord: "
set /p radius="Enter radius: "
set db=game.db

sqlite3 %db% "SELECT class, id, x, y, z FROM actor_position WHERE class LIKE '/Game/Systems/Building/Placeable%%' AND x <= (%x% + %radius%) AND x >= (%x% - %radius%) AND y <= (%y% + %radius%) AND y >= (%y% - %radius%);" >results.txt
for /f "tokens=1,2,3,4,5 delims=| " %%a in (results.txt) do (
 set class=%%a
 set id=%%b
 set xc=%%c
 set yc=%%d
 set zc=%%e
 echo TeleportPlayer !xc! !yc! !zc! Structure: !class! >>output.txt
)
start notepad output.txt
timeout 1
del output.txt
del results.txt
exit
