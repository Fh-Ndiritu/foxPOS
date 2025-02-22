@echo off
wsl bash -c "cd ~/code/foxPOS && chmod +x start_foxpos.sh && ./start_foxpos.sh"
timeout /t 5 /nobreak >nul
start chrome --new-window --app=http://localhost:3000
