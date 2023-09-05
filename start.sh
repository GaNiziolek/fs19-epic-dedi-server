
/usr/bin/supervisord &

legendary auth --code ${EPIC_AUTH_CODE}

# Start fake X
export DISPLAY=:0
/usr/bin/Xvfb $DISPLAY -ac &

echo Launching Farming Simulator 19 with "-server" args
legendary launch farming -server &

echo Waiting 10 seconds before launch dedicatedServer.exe
sleep 10

echo Launching dedicatedServer.exe
legendary launch farming --override-exe dedicatedServer.exe

