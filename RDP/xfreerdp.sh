read -s -p "Enter Remote Desktop USER: " REMOTE_USER ; echo  
read -s -p "Enter Remote Desktop PASSWORD: " REMOTE_PASSWORD ; echo  
read -s -p "Enter Remote Desktop IP: " REMOTE_IP ; echo  

xfreerdp /u:$REMOTE_USER /p:$REMOTE_PASSWORD /v:$REMOTE_IP /sound:sys:pulse /microphone:sys:pulse /w:1888 /h:994
