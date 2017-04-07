#!/bin/sh

gmt makecpt -Crainbow -T0/31/0.5 -I > colors.cpt

for file in `ls -1 path/ORAS4/DATA/monthly_1x1/thetao*.nc`
do
  #grdtemp
  echo $file
  for i in 1 #fevrier 0 1 2 3 4 5 6 7 8 9 10 11
  do
    	echo -n "month : " $(($i+1))
	gmt grd2xyz "$file?thetao[$i,0,,]" | gmt pscontour -R-180/180/-90/90 -JJ22 -B30g15 -Ccolors.cpt -S0.5 -K -A- -I > grdtemp.ps
	gmt pscoast -R -J -B -Wblack -Gwhite -O -K >> grdtemp.ps
	gmt psscale -D10.5/18/17/0.3h -B5 -Ccolors.cpt -O >> grdtemp.ps
	outf=`echo $file | awk -F"/" '{print $9}' | awk -F"_" -vm=$i '{print "PNG/"$4"_"m+1".png"}'`
	echo "  -->  $outf"
	gmt psconvert -Tg -F$outf -P grdtemp.ps
	rm grdtemp*
done

done

cat PNG/*.png | ffmpeg -f image2pipe -framerate 10 -i - test_ora.mp4

#rm PNG/*
