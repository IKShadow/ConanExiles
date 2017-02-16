@echo off
title Conan Exiles server
echo "Script will validate & update server files on every restart"
echo "On first run it will shutdown existing Conan Exiles Server"
timeout 3
SET GAMEPATH=C:\srv\ConanExiles\
SET STEAMPATH=C:\srv\steamcmd\ 
:loop
:: CLOSE CONAN SERVER IF ITS RUNNING ( in case server crashed but background processes did not close correctly)
tasklist /fi "ConanSandboxServer.exe" > nul
if errorlevel 1 taskkill /IM ConanSandboxServer.exe /T /F &

tasklist /fi "ConanSandboxServer-Win64-Test.exe" > nul
if errorlevel 1 taskkill /IM ConanSandboxServer-Win64-Test.exe /T /F &
:: RUN STEAM UPDATE
echo STEAM UPDATE STARTED AT %date% %time%
%STEAMPATH%steamcmd.exe +login anonymous +force_install_dir %GAMEPATH% +app_update 443030 validate +quit
:: RUN CONAN EXILES SERVER
echo SERVER STARTED AT %date% %time%
%GAMEPATH%ConanSandboxServer.exe "ConanSandbox" -log
echo SERVER STOPPED AT %date% %time%
goto loop
