#!/bin/bash
COUNTRY_LIST=countries.txt
MALE_NAMES=male_names.txt
FEMALE_NAMES=female_names.txt
BLOOD_TYPE_LIST=blood_types.txt
ETHNICITY_LIST=ethnicity.txt
RELIGION_LIST=religions.txt
PLACEHOLDER=null.txt
FORMAT_STRING_TWO_COL="%-14s%s %s %s %s %s\n"
count=1
padding=14
declare -A basicInformation
declare -A financialInformation
declare -A employmentInformation
declare -A personalInformation
declare -A onlineProfileInformation
declare -A otherInformation
numColumns=2
numRows=5
if [[ -e fields_and_filenames.txt && -s fields_and_filenames.txt ]] 
then
for ((i=1;i<=numRows;i++)) do
	for ((j=1;j<=numColumns;j++)) do
		basicInformation[$i,1]=$( awk 'BEGIN{FS=","} "FNR == $i {print $1; exit}"'  fields_and_filenames.txt )
	done
done
else
	exit
fi

printf '\f%s' "Enter number of identities you want to generate: "
read numberOfIdentities

while [ $numberOfIdentities -ge 1 ]
do
	sex=$((1 + RANDOM % 2))
	printf '%s\n' "========== ${count} =========="
	printf "\n%s\n"		        "Basic Information"
	if [ $sex -eq 1 ]
	then
		printf "$FORMAT_STRING_TWO_COL" "Name:" $( shuf -n 1 $MALE_NAMES )
		printf "$FORMAT_STRING_TWO_COL" "Sex:" "Male"
	else
		printf "$FORMAT_STRING_TWO_COL" "Name:" $( shuf -n 1 $FEMALE_NAMES )
		printf "$FORMAT_STRING_TWO_COL" "Sex:" "Female"
	fi
	printf "$FORMAT_STRING_TWO_COL" "Age: " $((15 + RANDOM % 80))
	printf "$FORMAT_STRING_TWO_COL" "Height:"  $((110 + RANDOM % 210)) "cm"
	printf "$FORMAT_STRING_TWO_COL" "Weight:"  $((50 + RANDOM % 150)) "kg"
	for ((i=1;i<=numRows;i++)) do
		printf "$FORMAT_STRING_TWO_COL" ${basicInformation[$i,1]}
		#shuf -n 1 ${basicInformation[$i,2]}
	done
	count=$[ $count + 1 ]
	numberOfIdentities=$[ $numberOfIdentities - 1]
	echo
done
# Based on statistics of leaving the country (for example at a specific age, such as expats) the FROM should equal RESIDENCY in nn% of the time, e.g. 93% should have FROM=RESIDENCY
