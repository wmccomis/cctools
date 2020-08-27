#!/usr/bin/gnuplot


reset


set terminal png
set output 'perfdata-write.png'
set key off

set border linewidth 1.5
set style line 1 \
    linecolor rgb '#0060ad' \
    linetype 1 linewidth 2 \
    pointtype 7 pointsize 1.5

#set logscale xy
set xlabel "Jobs"
set ylabel "MB written"
set title "Makeflow Performance With Increase in Jobs"

plot 'perfdata.dat' using 1:6 with points ls 1
