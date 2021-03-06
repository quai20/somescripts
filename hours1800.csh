#!/bin/bash
# K.BALEM - IFREMER LOPS - 2017
# Usage : 
# Doc : ./hours1800 -h
# Current date to hours1800  : ./hours1800.csh
# Calendar date to hours1800 : ./hours1800.csh 10 02 2016 10 35 45
# hours1800 to Calendar date : ./hours1800.csh 24146.575

case "$#" in
	0 ) #current date to jour1800
		day=`date +%d`
        	mon=`date +%m`
		yea=`date +%Y`
        	hou=`date +%H`
        	min=`date +%M`
 		sec=`date +%S` 
 		printf "\nCalendar date : $day/$mon/$yea-$hou:$min:$sec \n\n"
                start="Jan 1 1800 00:00:00"     #CNES
                 jd=$(( ( $(date -d "$yea$mon$day" +%s) - $(date -d "$start" +%s) ) /(24 * 60 * 60 ) ))
                 ttime=$(echo $hou $min $sec | awk '{print $1/24 +$2/(60*24)+ $3/(60*60*24)}')
                 rjul=$(echo $jd $ttime | awk '{printf "%5.10f\n", $1*24+$2*24}')
		printf "Hours since 1800 : $rjul\n\n"
		;;

	1 )  #jour1800 to date
		if [ $1 == "-h" ]
	   	then
		printf "Usage :\nCurrent date to hours since 1800  : ./jours1800.csh\nCalendar date to hours since 1800 : ./jours1800.csh DD MM YYYY HH MM SS\nHours Since 1800 to Calendar date : ./jours1800.csh Hours\n"
		else
		start="Jan 1 1800 00:00:00"      #CNES
		epo=`echo $1 | awk '{printf("%d",$1*60*60)}'`
                eps=`date -d "$start" +%s`	
		repo=$(($epo+$eps))
		
                echo "Calendar Date : " `date -d @$repo`
		fi
		;;

	6 )  #date to 1800
		day=$1
        	mon=$2
		yea=$3
        	hou=$4
        	min=$5
 		sec=$6 
 		printf "\nCalendar date : $day/$mon/$yea-$hou:$min:$sec \n\n"
                start="Jan 1 1800 00:00:00" 
                 jd=$(( ( $(date -d "$yea$mon$day" +%s) - $(date -d "$start" +%s) ) /(24 * 60 * 60 ) ))
                 ttime=$(echo $hou $min $sec | awk '{print $1/24 +$2/(60*24)+ $3/(60*60*24)}')
                 rjul=$(echo $jd $ttime | awk '{printf "%5.10f\n", $1*24+$2*24}')
		printf "Hours since 1800 : $rjul\n\n"
		;;

        *) 
                 printf "Usage :\nCurrent date to hours since 1800  : ./jours1800.csh\nCalendar date to hours since 1800 : ./jours1800.csh DD MM YYYY HH MM SS\nHours Since 1800 to Calendar date : ./jours1800.csh Hours\n"
		;;
esac



