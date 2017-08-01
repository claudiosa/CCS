set terminal svg dashed size 800, 600 fsize 20
set output "compl1.svg"
set grid back
set xlabel "Elementos (n)"
set ylabel "Número de operações"
set decimalsign ','
set xrange [0:100]
set key top left
plot x title "O(n)" w l lw 6, x * log(x) title "O(n log n)" w l lw 6
