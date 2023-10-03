#!/bin/bash

# цветовая схема по умолчанию: 3 5 2 4
source color_scheme.conf
color_arr=("white" "red" "green" "blue" "purple" "black")
default_colors=0
if [[ $column1_background -eq 0 && $column1_font_color1 -eq 0 && $column2_background -eq 0 && $column2_font_color -eq 0 ]]; then default_colors=1; fi;
if [[ $column1_background -eq 0 ]]; then column1_background=3; fi;
if [[ $column2_background -eq 0 ]]; then column2_background=2; fi;
if [[ $column1_font_color -eq 0 ]]; then column1_font_color=5; fi;
if [[ $column2_font_color -eq 0 ]]; then column2_font_color=4; fi;

Color_Off='\033[0m'
if [[ $column1_background -ne $column1_font_color && $column2_background -ne $column2_font_color ]]
then
timezone=$(cat /etc/timezone)" UTC "$(date +"%z")
os=$(cat /etc/issue | grep . | awk '{print $1, $2, $3}')
date=$(date +"%d %B %Y %H:%M:%S")
uptime=$(uptime -p)
uptime_sec=$(awk '{print $1}' /proc/uptime)
ip=$(ifconfig | grep "inet " | awk '{print $2}' | head -1)
netmask=$(ifconfig | grep "inet " | awk '{print $4}' | head -1)
gateway=$(ip r | grep "default via" | awk '{print $3}')
ram_total=$(echo "scale=3;$(free -t | grep "Total:" | awk '{print $2}')/(1024^2)" | bc -l)
ram_used=$(echo "scale=3;$(free -t | grep "Total:" | awk '{print $3}')/(1024^2)" | bc -l)
ram_free=$(echo "scale=3;$(free -t | grep "Total:" | awk '{print $4}')/(1024^2)" | bc -l)
space_root=$(echo "scale=2;$(df --block-size=1 /root | awk '{print $2}')/(1024^2)" | bc -l | tail -1)
space_root_used=$(echo "scale=2;$(df --block-size=1 /root | awk '{print $3}' | tail -1)/(1024^2)" | bc -l)
space_root_free=$(echo "scale=2;$(df --block-size=1 /root | awk '{print $4}' | tail -1)/(1024^2)" | bc -l)

# 1 - white, 2 - red, 3 - green, 4 - blue, 5 – purple, 6 - black

if [[ $column1_background -eq 1 ]]; then color1='\033[47m'
elif [[ $column1_background -eq 2 ]]; then color1='\033[41m'
elif [[ $column1_background -eq 3 ]]; then color1='\033[42m'
elif [[ $column1_background -eq 4 ]]; then color1='\033[44m'
elif [[ $column1_background -eq 5 ]]; then color1='\033[45m'
elif [[ $column1_background -eq 6 ]]; then color1='\033[40m'
fi

if [[ $column2_background -eq 1 ]]; then color3='\033[47m'
elif [[ $column2_background -eq 2 ]]; then color3='\033[41m'
elif [[ $column2_background -eq 3 ]]; then color3='\033[42m'
elif [[ $column2_background -eq 4 ]]; then color3='\033[44m'
elif [[ $column2_background -eq 5 ]]; then color3='\033[45m'
elif [[ $column2_background -eq 6 ]]; then color3='\033[40m'
fi

if [[ $column1_font_color -eq 1 ]]; then color2='\033[0;37m'
elif [[ $column1_font_color -eq 2 ]]; then color2='\033[0;31m'
elif [[ $column1_font_color -eq 3 ]]; then color2='\033[0;32m'
elif [[ $column1_font_color -eq 4 ]]; then color2='\033[0;34m'
elif [[ $column1_font_color -eq 5 ]]; then color2='\033[0;35m'
elif [[ $column1_font_color -eq 6 ]]; then color2='\033[0;30m'
fi

if [[ $column2_font_color -eq 1 ]]; then color4='\033[0;37m'
elif [[ $column2_font_color -eq 2 ]]; then color4='\033[0;31m'
elif [[ $column2_font_color -eq 3 ]]; then color4='\033[0;32m'
elif [[ $column2_font_color -eq 4 ]]; then color4='\033[0;34m'
elif [[ $column2_font_color -eq 5 ]]; then color4='\033[0;35m'
elif [[ $column2_font_color -eq 6 ]]; then color4='\033[0;30m'
fi

status="${color2}${color1}HOSTNAME=${color4}${color3}$HOSTNAME${Color_Off}\n${color2}${color1}TIMEZONE=${color4}${color3}$timezone${Color_Off}\n${color2}${color1}USER=${color4}${color3}$USER${Color_Off}\n${color2}${color1}OS=${color4}${color3}$os${Color_Off}\n${color2}${color1}DATE=${color4}${color3}$date${Color_Off}\n${color2}${color1}UPTIME=${color4}${color3}$uptime${Color_Off}\n${color2}${color1}UPTIME_SEC=${color4}${color3}$uptime_sec${Color_Off}\n${color2}${color1}IP=${color4}${color3}$ip${Color_Off}\n${color2}${color1}MASK=${color4}${color3}$netmask${Color_Off}\n${color2}${color1}GATEWAY=${color4}${color3}$gateway${Color_Off}\n${color2}${color1}RAM_TOTAL=${color4}${color3}$ram_total GB${Color_Off}\n${color2}${color1}RAM_USED=${color4}${color3}$ram_used GB${Color_Off}\n${color2}${color1}RAM_FREE=${color4}${color3}$ram_free GB${Color_Off}\n${color2}${color1}SPACE_ROOT=${color4}${color3}$space_root MB${Color_Off}\n${color2}${color1}SPACE_ROOT_USED=${color4}${color3}$space_root_used MB${Color_Off}\n${color2}${color1}SPACE_ROOT_FREE=${color4}${color3}$space_root_free MB${Color_Off}"
echo -e $status
echo
if [[ $default_colors -eq 1 ]]
then
color_scheme="Column 1 background = default (${color_arr[($column1_background - 1)]}) \nColumn 1 font color = default (${color_arr[($column1_font_color - 1)]})\nColumn 2 background = default (${color_arr[($column2_background - 1)]})\nColumn 2 font color = default (${color_arr[($column2_font_color - 1)]})"
else
color_scheme="Column 1 background = $column1_background (${color_arr[($column1_background - 1)]})\nColumn 1 font color = $column1_font_color (${color_arr[($column1_font_color - 1)]})\nColumn 2 background = $column2_background (${color_arr[($column2_background - 1)]})\nColumn 2 font color = $column2_font_color (${color_arr[($column2_font_color - 1)]})"
fi
echo -e $color_scheme;
else
echo "Wrong input: 1st and 2nd parameters should differ; 3rd and 4th parameters should differ"
fi