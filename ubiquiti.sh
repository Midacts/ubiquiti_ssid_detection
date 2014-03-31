#!/bin/bash
# Ubiquiti UAP-PRO Wireless SSID Detection Script
# Author: John McCarthy
# <http://www.midactstech.blogspot.com> <https://www.github.com/Midacts>
# Date: 31st of March, 2014
# Version 1.0
#
# To God only wise, be glory through Jesus Christ forever. Amen.
# Romans 16:27, I Corinthians 15:1-4
#---------------------------------------------------------------
#
# Email Variables
#
# Hostname of the AP
host=$(sshpass -p "PASSWORD" ssh admin@HOST "hostname")
# Email subject
subject="ROGUE WIRELESS AP DETECTED ON $host"
# Sender email
sender="ubnt@domain.com"
# Recipient email
recipient="you're_email@domain.com"
#
# List of acceptable SSIDs
#
checklist=('List' 'of' 'known' 'or' 'acceptable' 'SSIDs')
#
# Variables to get list of scanned SSIDs form the Ubiquiti UAP-PRO
#
mapfile -t ath0 < <(sshpass -p "PASSWORD" ssh admin@HOST 'iwlist ath0 scanning' | sed -n 's/^[[:blank:]]*ESSID:"\(.*\)"$/\1/p')
mapfile -t ath1 < <(sshpass -p "PASSWORD" ssh admin@HOST 'iwlist ath1 scanning' | sed -n 's/^[[:blank:]]*ESSID:"\(.*\)"$/\1/p')
mapfile -t ath2 < <(sshpass -p "PASSWORD" ssh admin@HOST 'iwlist ath2 scanning' | sed -n 's/^[[:blank:]]*ESSID:"\(.*\)"$/\1/p')
mapfile -t ath3 < <(sshpass -p "PASSWORD" ssh admin@HOST 'iwlist ath3 scanning' | sed -n 's/^[[:blank:]]*ESSID:"\(.*\)"$/\1/p')

echo "ath0 equals ${ath0[@]}"
for (( i=0; i<"${#ath0[@]}"; i++ ))
do
        # Sets the variable that checks for a match to zero
        match=0
        # Creates a for loop that loops through the list array
        for (( j=0; j<="${#checklist[@]}"; j++ ))
        do
                # Checks whether the ${ssid_0[$i]} value is in the ${checlist[$j]} array
                # It is checking to make sure there is not a new SSID
                test "${ath0[$i]}" == "${checklist[$j]}" && match=1
		if [ "${ath0[$i]}" == "${checklist[$j]}" ]; then
			echo "${ath0[$i]} is a match!"
		fi
        done
        if [ "$match" -eq 0 ];then
                name+=( $(echo "${ath0[$i]}") )
        fi
done

echo
echo "NEXT ATH"
echo

echo "ath1 equals ${ath1[@]}"
# Create a for loop that loops through every value in your ath1 array
for (( i=0; i<"${#ath1[@]}"; i++ ))
do
        # Sets the variable that checks for a match to zero
        match=0
        # Creates a for loop that loops through the list array
        for (( j=0; j<="${#checklist[@]}"; j++ ))
        do
                # Checks whether the ${ssid_1[$i]} value is in the ${checklist[$j]} array
                # It is checking to make sure there is not a new SSID
                test "${ath1[$i]}" == "${checklist[$j]}" && match=1
                if [ "${ath1[$i]}" == "${checklist[$j]}" ]; then
                        echo "${ath1[$i]} is a match!"
                fi
        done
        if [ "$match" -eq 0 ];then
                name+=( $(echo "${ath1[$i]}") )
        fi
done

echo
echo "NEXT ATH"
echo

echo "ath2 equals ${ath2[@]}"
# Create a for loop that loops through every value in your ath0 array
for (( i=0; i<"${#ath2[@]}"; i++ ))
do
        # Sets the variable that checks for a match to zero
        match=0
        # Creates a for loop that loops through the list array
        for (( j=0; j<="${#checklist[@]}"; j++ ))
        do
                # Checks whether the ${ssid_0[$i]} value is in the ${checlist[$j]} array
                # It is checking to make sure there is not a new SSID
                test "${ath2[$i]}" == "${checklist[$j]}" && match=1
                if [ "${ath2[$i]}" == "${checklist[$j]}" ]; then
                        echo "${ath2[$i]} is a match!"
                fi
        done
        if [ "$match" -eq 0 ];then
                name+=( $(echo "${ath2[$i]}") )
        fi
done

echo
echo "NEXT ATH"
echo

echo "ath3 equals ${ath3[@]}"
# Create a for loop that loops through every value in your ath3 array
for (( i=0; i<"${#ath3[@]}"; i++ ))
do
        # Sets the variable that checks for a match to zero
        match=0
        # Creates a for loop that loops through the list array
        for (( j=0; j<="${#checklist[@]}"; j++ ))
        do
                # Checks whether the ${ath2[$i]} value is in the ${checklist[$j]} array
                # It is checking to make sure there is not a new SSID
                test "${ath3[$i]}" == "${checklist[$j]}" && match=1
                if [ "${ath3[$i]}" == "${checklist[$j]}" ]; then
                        echo "${ath3[$i]} is a match!"
                fi
        done
	# Adds the rogue AP SSID to the name array
        if [ "$match" -eq 0 ];then
                name+=( $(echo "${ath3[$i]}") )
        fi
done

# Adds all rogue APs from the name array to the rogue array (removing any duplicates)
rogues=$(printf '%s\n' "${name[@]}" | sort | uniq)

rogue_alert () {
(
    echo "From: ${sender}"
    echo "Subject: ${subject}"
    echo "Importance: High"
    echo "X-Priority: 1"
    echo
    echo "NEWLY DETECTED ROGUE ACCESS POINTS ON ${host}"
    echo
    count=1
    for item in ${rogues[@]}; do
        printf "SSID %d is:  %s\n" "$count" "$item"
        ((count++))
        arrow=">>"
    done
    echo
) | /usr/sbin/sendmail "$recipient"
}

rogue_alert

#
# REFERENCES
#
# http://stackoverflow.com/questions/4609949/what-does-1-in-sed-do
# http://www.linuxquestions.org/questions/programming-9/bash-combine-arrays-and-delete-duplicates-882286/
#
