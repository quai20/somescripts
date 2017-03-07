#!/bin/bash
# K.BALEM - IFREMER LOPS - 2017
# Usage : 
# Doc : ./juld -h
# Current date to JULD  : ./juld.csh
# Calendar date to JULD : ./juld.csh 10 02 2016 10 35 45
# JULD to Calendar date : ./juld.csh 24146.575

case "$#" in
	0 ) #current date to JULD
		day=`date +%d`
        	mon=`date +%m`
		yea=`date +%Y`
        	hou=`date +%H`
        	min=`date +%M`
 		sec=`date +%S` 
 		printf "\nCalendar date : $day/$mon/$yea-$hou:$min:$sec \n\n"
                start="Jan 1 1950 00:00:00"     #CNES
                # start="Jan 1 1958 00:00:00"   #NASA
                # Julian Day
                 jd=$(( ( $(date -d "$yea$mon$day" +%s) - $(date -d "$start" +%s) ) /(24 * 60 * 60 ) ))
                 ttime=$(echo $hou $min $sec | awk '{print $1/24 +$2/(60*24)+ $3/(60*60*24)}')
                 rjul=$(echo $jd $ttime | awk '{printf "%5.10f\n", $1+$2}')
		printf "CNES Standard Realtime Julian Day : $rjul\n\n"
		;;

	1 )  #JULD to date
		if [ $1 == "-h" ]
	   	then
		printf "Usage :\nCurrent date to JULD  : ./juld.csh\nCalendar date to JULD : ./juld.csh DD MM YYYY HH MM SS\nJULD to Calendar date : ./juld.csh JULD\n"
		else
		start="Jan 1 1950 00:00:00"      #CNES
                # start="Jan 1 1958 00:00:00"    #NASA
		epo=`echo $1 | awk '{printf("%d",$1*24*60*60)}'`
                eps=`date -d "$start" +%s`	
		repo=$(($epo+$eps))
		
                echo "Calendar Date : " `date -d @$repo`
		fi
		;;

	6 )  #date to JULD
		day=$1
        	mon=$2
		yea=$3
        	hou=$4
        	min=$5
 		sec=$6 
 		printf "\nCalendar date : $day/$mon/$yea-$hou:$min:$sec \n\n"
                start="Jan 1 1950 00:00:00"     #CNES
                # start="Jan 1 1958 00:00:00"   #NASA
                # Julian Day
                 jd=$(( ( $(date -d "$yea$mon$day" +%s) - $(date -d "$start" +%s) ) /(24 * 60 * 60 ) ))
                 ttime=$(echo $hou $min $sec | awk '{print $1/24 +$2/(60*24)+ $3/(60*60*24)}')
                 rjul=$(echo $jd $ttime | awk '{printf "%5.10f\n", $1+$2}')
		printf "CNES Standard Realtime Julian Day : $rjul\n\n"
		;;

        *) 
                 printf "Usage :\nCurrent date to JULD  : ./juld.csh\nCalendar date to JULD : ./juld.csh DD MM YYYY HH MM SS\nJULD to Calendar date : ./juld.csh JULD\n"
		;;
esac



