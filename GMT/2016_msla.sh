#!/bin/sh

gmt makecpt -Crainbow -T0/1.5/0.1 -I > colors.cpt

for file in `ls -1 some-path-to-msla/all-sat-merged/uv/2016/*.nc`
do
#grdtemp
echo -n $file
gmt grdmath "$file?u" "$file?v" HYPOT = grdtemp.grd
gmt grd2xyz grdtemp.grd | gmt pscontour -R-90/20/20/70 -JJ22 -B30g15 -Ccolors.cpt -S0.5 -K -A- -I > grdtemp.ps
gmt pscoast -R -J -B -Wblack -Gwhite -O -K >> grdtemp.ps
gmt psscale -D10/15/17/0.3h -B0.2 -Ccolors.cpt -O >> grdtemp.ps

outf=`echo $file | awk -F"/" '{print $11}' | awk -F"_" '{print "PNG/"$6".png"}'`
echo "  -->  $outf"
gmt psconvert -Tg -F$outf -P grdtemp.ps

rm grdtemp*
done
