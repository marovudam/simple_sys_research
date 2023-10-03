#!/bin/bash
source color_scheme.conf
if [[ "$column1_background" -le 6 && "$column1_background" -ge 0 && "$column2_background" -le 6 && "$column2_background" -ge 0 &&"$column1_font_color" -le 6 && "$column1_font_color" -ge 0 &&"$column2_font_color" -le 6 && "$column2_font_color" -ge 0 ]]
then
./analyze.sh
else
echo "Wrong input. Configuration file variables should contain values from 1 to 6"
fi