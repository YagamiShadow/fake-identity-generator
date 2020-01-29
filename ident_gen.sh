#!/bin/bash
#shellcheck disable=SC2059
#shellcheck disable=SC2034
COUNTRY_LIST=countries.txt
MALE_NAMES=male_names.txt
FEMALE_NAMES=female_names.txt
PLACEHOLDER=null.txt
count=1
padding=24
FORMAT_STRING_TWO_COL="%-${padding}s%s %s %s %s %s\n"
#declare -a basicInformation
BLOODTYPE=(A+ A- B+ B- AB+ AB- O+ O-)
SEX=(Male Female Non-Binary)
SEXUAL_IDENTITY=(Heterosexual Bisexual Homosexual Transsexual)
STATUS=(Single Married Engaged)
ETHNICITY=(Arab Latino Caucasian Afro)
RELIGION=(Islam Christianity Judaism Rastafari Buddhism Hinduism)
HAIR_COLOR=(Black Gray Brown White Blonde)
COLORS=('Red' 'Orange' 'Yellow' 'Green' 'Cyan' 'Blue' 'Indigo' 'Violet' 'Purple' 'Magenta' 'Pink' 'Brown' 'White' 'Gray' 'Black')
INTERESTS=('Travelling' 'Reading' 'Blogging' 'Hiking' 'Fishing' 'Art' 'Music' 'Volunteering')
PERSONALITY_TRAITS_POSITIVE=()
DANISH_COUNTRY_PREFIX="+45"
DANISH_MOBILE_PREFIX=(20 21 22 23 24 25 26 27 28 29 30 31 40 41 42 50 51 52 53 60 61 71 81 91 92 93)
# https://ens.dk/ansvarsomraader/telefoni/numre/den-danske-nummerplan 
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
	printf "$FORMAT_STRING_TWO_COL" "Age: " $(( RANDOM % 13 + 62))
	printf "$FORMAT_STRING_TWO_COL" "Height:"  $(( RANDOM % 145 + 75)) "cm"
	printf "$FORMAT_STRING_TWO_COL" "Weight:"  $(( RANDOM % 50 + 100)) "kg"
	first_digits=$[RANDOM % ${#DANISH_MOBILE_PREFIX[@]}]
	printf "%-${padding}s%-s" "Phone No.:" "${DANISH_COUNTRY_PREFIX}"
       	printf " %-d%06d\n" "${DANISH_MOBILE_PREFIX[${first_digits}]}" "$((RANDOM % 999999))"
	printf "$FORMAT_STRING_TWO_COL" "Bloodtype:" "${BLOODTYPE[$[RANDOM % ${#BLOODTYPE[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Ethnicity:" "${ETHNICITY[$[RANDOM % ${#ETHNICITY[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Religion:" "${RELIGION[$[RANDOM % ${#RELIGION[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Civil Status:" "${STATUS[$[RANDOM % ${#STATUS[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Sexual Identity:" "${SEXUAL_IDENTITY[$[RANDOM % ${#SEXUAL_IDENTITY[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Mothers Maiden Name:" "..."
	printf "$FORMAT_STRING_TWO_COL" "SSN:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Geo Coordinates:" "..."
	# Geo coordinates ##.#####, -##.######
	printf "\n%s\n"		        "Online Identities"
	printf "$FORMAT_STRING_TWO_COL" "Facebook:" "[x]"
	printf "$FORMAT_STRING_TWO_COL" "Instagram:" "[x]"
	printf "$FORMAT_STRING_TWO_COL" "Snapchat:" "[ ]"
	printf "$FORMAT_STRING_TWO_COL" "TikTok:" "[ ]"
	printf "$FORMAT_STRING_TWO_COL" "Weibo:" "[ ]"
	printf "$FORMAT_STRING_TWO_COL" "Weechat:" "[x]"
	printf "$FORMAT_STRING_TWO_COL" "Email:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Browser User-Agent:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Known Passwords:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Websites:" "..." "..."
	printf "$FORMAT_STRING_TWO_COL" "Hair Color:" "${HAIR_COLOR[$[RANDOM % ${#HAIR_COLOR[@]}]]}"

	printf "$FORMAT_STRING_TWO_COL" "Educational Background:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Passport:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Driver License:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Family Members:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Interests:" "${INTERESTS[$[RANDOM % ${#INTERESTS[@]}]]}"

	
	printf "\n%s\n"		        "Financial Information"
	printf "$FORMAT_STRING_TWO_COL" "Credit Card:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Expires:" "..."
	printf "$FORMAT_STRING_TWO_COL" "CVC2:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Paypal:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Account Balance:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Prederred Payment:" "Credit card"
	
	printf "\n%s\n"		        "Employment"
	printf "$FORMAT_STRING_TWO_COL" "Company:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Occupation:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Monthly Salary:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Employment Status:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Company Size:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Industry:" "..."
	
	printf "\n%s\n"		        "Other Information"
	printf "$FORMAT_STRING_TWO_COL" "Favorite Color:" "${COLORS[$[RANDOM % ${#COLORS[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Vehicle:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Car License Plate:" "..."
	printf "$FORMAT_STRING_TWO_COL" "GUID:" "..."
	printf "$FORMAT_STRING_TWO_COL" "QR Code:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Movie:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Music Genre:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Song:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Book:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Sport:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite TV Show:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Movie Star:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Singer:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Food:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Personality:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Last Known IP:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Timezone:" "..."
	
	count=$(( count + 1 ))
	numberOfIdentities=$(( numberOfIdentities - 1 ))
	echo
done
# Based on statistics of leaving the country (for example at a specific age, such as expats) the FROM should equal RESIDENCY in nn% of the time, e.g. 93% should have FROM=RESIDENCY
