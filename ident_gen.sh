#!/bin/bash
#shellcheck disable=SC2059
#shellcheck disable=SC2034
COUNTRY_LIST=countries.txt
MALE_NAMES=male_names.txt
FEMALE_NAMES=female_names.txt
PLACEHOLDER=null.txt

FORMAT_STRING_TWO_COL="%-14s%s %s %s %s %s\n"
count=1
padding=14
declare -a basicInformation

BLOODTYPE=(A+ A- B+ B- AB+ AB- O+ O-)
SEX=(Male Female Non-Binary)
SEXUAL_IDENTITY=(Heterosexual Bisexual Homosexual Transsexual)
STATUS=(Single Married Engaged)
ETHNICITY=(Arab Latino Caucasian Afro)
RELIGION=(Islam Christianity Judaism Rastafari Buddhism Hinduism)

printf '\f%s' "Enter number of identities you want to generate: "
read -r numberOfIdentities

while [ "$numberOfIdentities" -ge 1 ]
do
	sex=$((1 + RANDOM % 2))
	printf '%s\n' "========== ${count} =========="
	printf "\n%s\n"		        "Basic Information"
	if [ $sex -eq 1 ]
	then
		printf "$FORMAT_STRING_TWO_COL" "Name:" "$( shuf -n 1 $MALE_NAMES )"
		printf "$FORMAT_STRING_TWO_COL" "Sex:" "Male"
	else
		printf "$FORMAT_STRING_TWO_COL" "Name:" "$( shuf -n 1 $FEMALE_NAMES )"
		printf "$FORMAT_STRING_TWO_COL" "Sex:" "Female"
	fi
	printf "$FORMAT_STRING_TWO_COL" "Age: " $((15 + RANDOM % 80))
	printf "$FORMAT_STRING_TWO_COL" "Height:"  $((110 + RANDOM % 210)) "cm"
	printf "$FORMAT_STRING_TWO_COL" "Weight:"  $((50 + RANDOM % 150)) "kg"
	# Phone
	# Country code
	# Mothers maiden name
	# Geo coordinates ##.#####, -##.######
	# SSN 

	## Online identities
	#Facebook
	#	Email-address
	#	username
	#	password
	#	Browser user-agent
	#	
	#Instagram
	# ..
	# ..
	# ..
	# Owned websites

	# Employment
	#	Company
	# 	Occupation
	# 	Salary

	## Finance
	# Credit card: #### #### #### ####
	# Expires ##/##
	# CVC2 ###

	## Other
	#	Favorite color
	#	Vehicle
	#	GUID
	#	QR Code (generate)

	count=$(( count + 1 ))
	numberOfIdentities=$(( numberOfIdentities - 1 ))
	echo
done
# Based on statistics of leaving the country (for example at a specific age, such as expats) the FROM should equal RESIDENCY in nn% of the time, e.g. 93% should have FROM=RESIDENCY
