#!/bin/bash

# make_max_mag_kml.sh - script to write some kml syntax stuff
# seems pretty horrendous, wish me luck

# gjf, 07-oct-2025

infile='daily_max_magnitude.txt' # daily maximum magnitude earthquake catalog entries
inkml='example.kml'   # kml file for a single point with some junk cut out

outplaces='placemarks.kml'  # where we will output our placemark information
outkml='daily_max_magnitude.kml'  # the final output kml file

# remove placemarks file
rm -f $outplaces

# read through the catalog file and write out some formatted kml
# built to match the tabs and tags in the example file 
awk '{printf("\t<Placemark>\n\t\t<name>%s</name>\n\t\t<styleUrl>#m_ylw-pushpin</styleUrl>\n\t\t<Point>\n\t\t\t<coordinates>%f,%f,0</coordinates>\n\t\t</Point>\n\t</Placemark>\n",$1, $7, $6)}'  $infile >> $outplaces

# now assemble your kml file
head -32 $inkml > $outkml
cat $outplaces >> $outkml
tail -2 $inkml >> $outkml

