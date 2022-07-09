#!/bin/bash

cat << "EOF" 
      ______                       __              __        __                               
     /      \                     |  \            |  \      |  \                              
    |  $$$$$$\  ______    _______ | $$____        | $$       \$$ _______   __    __  __    __ 
    | $$__| $$ /      \  /       \| $$    \       | $$      |  \|       \ |  \  |  \|  \  /  \
    | $$    $$|  $$$$$$\|  $$$$$$$| $$$$$$$\      | $$      | $$| $$$$$$$\| $$  | $$ \$$\/  $$
    | $$$$$$$$| $$   \$$| $$      | $$  | $$      | $$      | $$| $$  | $$| $$  | $$  >$$  $$ 
    | $$  | $$| $$      | $$_____ | $$  | $$      | $$_____ | $$| $$  | $$| $$__/ $$ /  $$$$\ 
    | $$  | $$| $$       \$$     \| $$  | $$      | $$     \| $$| $$  | $$ \$$    $$|  $$ \$$\
     \$$   \$$ \$$        \$$$$$$$ \$$   \$$       \$$$$$$$$ \$$ \$$   \$$  \$$$$$$  \$$   \$$
                                                                                             
                                                                                             
                                                                                             
EOF
echo   ; sleep 2 ;

# PROMPT TO CONFIGURE THE SYSTEM #
    while true;
        read -p "Would you like to configure the base system ?  [Y/n] " yn
        case $yn in
            [Yy]* ) bash "$PWD/scripts/base-sys-config"; break;;
            [Nn]* ) echo "Cancelled !"; sleep 2 ; break;;
            * ) echo "Please answer with Y[es] or N[o].";;
        esac
    done

# PROMPT TO INSTALL BASE PACKAGES #
    while true; do
        read -p "Would you like to install base-packages ?  [Y/n] " yn
        case $yn in
            [Yy]* ) bash "$PWD/scripts/base-packages"; break;;
            [Nn]* ) echo "Cancelled !"; sleep 2 ; break;;
            * ) echo "Please answer with Y[es] or N[o].";;
        esac
    done

