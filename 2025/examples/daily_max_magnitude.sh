#!/bin/bash

# script to loop through several files and do awk things

# set up an output filename
outfile='daily_max_magnitude.txt'

# delete that file if it exists (-f means no complaining)
rm -f $outfile

# loop through all the files
for infile in *.dat

do 

    # 1. set a small number as maximum maggnitude (maxm)
    # 2. if the magnitude (column 4) on a given line is greater than maxm...
    #    make that magnitude the new maxm
    #    and save that line to the variable catentry
    # 3. at the end of the day, write out catentry 
#    awk 'BEGIN{maxm=-9999}{if($4>maxm){maxm=$4; catentry=$0}}END{print catentry}' $infile >> $outfile

    # 1. if you only want to report the largest magnitude, you can just update maxm and print it at the end
#    awk 'BEGIN{maxm=-9999}{if($4>maxm)maxm=$4}END{print "On",$1,"the largest earthquake was M"maxm}' $infile >> $outfile
    
    # or... 
    # 1. sort the file numerically by column 4
    # 2. extract the last line
    sort -nk 4 $infile | tail -1 >> $outfile


done
