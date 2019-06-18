#!/bin/bash
oplrun -w -deploy transportation_V3.mod transportation_V3.dat 
#oplrun -w  transportation_V3.mod transportation_V3.dat 
clear
echo "========================================================"
echo "OUTPUT FILE: output_model_RUN.txt"
cat output_model_RUN.txt
echo "End of script"
