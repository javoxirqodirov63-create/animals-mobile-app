@echo off
chcp 65001 > nul
echo ========================================================
echo        Animals-uz Server va Ilovasini Ishga Tushirish
echo ========================================================
echo 1. Server ishga tushmoqda (http://localhost:5000)...
start "Animals-uz Server" cmd /k "node server/server.js"
timeout /t 2 /nobreak > nul
echo 2. Ilova brauzerda ochilmoqda (http://localhost:7777)...
start "Animals-uz App" cmd /k "C:\src\flutter\bin\flutter.bat run -d chrome --web-port 7777"
echo Barchasi tayyor!
