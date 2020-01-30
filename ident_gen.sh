#!/bin/bash
#shellcheck disable=SC2059
#shellcheck disable=SC2034
#shellcheck disable=SC2007
#Fix SC2007

# TEXT FORMATTING
count=1
padding=24
page_with=80 # show multiple "pages" on the same screen. Use awk
FORMAT_STRING_TWO_COL="%-${padding}s%s %s %s %s %s\n"

# FILE LOCATIONS
COUNTRY_LIST=countries.txt
MALE_NAMES=male_names.txt
FEMALE_NAMES=female_names.txt
PLACEHOLDER=null.txt

# VARIABLES
declare -A COUNTRY_PREFIX

# PROGRAM DATA
BLOODTYPE=(A+ A- B+ B- AB+ AB- O+ O-)
SEX=(Male Female Non-Binary)
SEXUAL_IDENTITY=(Heterosexual Bisexual Homosexual Transsexual)
CIVIL_STATUS=(Single Married Engaged)
ETHNICITY=(Arab Latino Caucasian Afro)
RELIGION=(Islam Christianity Judaism Rastafari Buddhism Hinduism)
HAIR_COLOR=(Black Gray Brown White Blonde)
COMPANY_SIZE=('1-4' '5-9' '10-19' '20-49' '50-99' '100-249' '500-999' '1000+')
INDUSTRY_SECTOR=('Farming' 'Fishing' 'Finances' 'Services' 'Engineering' 'Consultance')
PREFERRED_PAYMENT_TYPE=('Cash' 'Credit Card' 'Check' 'Cryptocurrency')
COLORS=('Red' 'Orange' 'Yellow' 'Green' 'Cyan' 'Blue' 'Indigo' 'Violet' 'Purple' 'Magenta' 'Pink' 'Brown' 'White' 'Gray' 'Black')
INTERESTS=('Travelling' 'Reading' 'Blogging' 'Hiking' 'Fishing' 'Art' 'Music' 'Volunteering')
COUNTRY_PREFIX[DA]="+45"
DANISH_MOBILE_PREFIX=(20 21 22 23 24 25 26 27 28 29 30 31 40 41 42 50 51 52 53 60 61 71 81 91 92 93) # Source: https://ens.dk/ansvarsomraader/telefoni/numre/den-danske-nummerplan 

# SCRIPT PARAMETERS
if [ -z "${1}" ]; then
		echo "Missing parameter - please specify number of identites you wish to generate."
		exit ;
	else
		numberOfIdentities=${1}
fi

# BUSINESS LOGIC
while [ "$numberOfIdentities" -ge 1 ]
do
	# PERSONAL INFORMATION
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
	printf "%-${padding}s%-s" "Phone No.:" "${COUNTRY_PREFIX[DA]}"
       	printf " %-d%06d\n" "${DANISH_MOBILE_PREFIX[${first_digits}]}" "$((RANDOM % 999999))"
	printf "$FORMAT_STRING_TWO_COL" "Bloodtype:" "${BLOODTYPE[$[RANDOM % ${#BLOODTYPE[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Ethnicity:" "${ETHNICITY[$[RANDOM % ${#ETHNICITY[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Religion:" "${RELIGION[$[RANDOM % ${#RELIGION[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Civil Status:" "${CIVIL_STATUS[$[RANDOM % ${#CIVIL_STATUS[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Sexual Identity:" "${SEXUAL_IDENTITY[$[RANDOM % ${#SEXUAL_IDENTITY[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Mothers Maiden Name:" "..."
	printf "$FORMAT_STRING_TWO_COL" "SSN:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Geo Coordinates:" "..."	# Geo coordinates ##.#####, -##.######

	# ONLINE IDENTITIES
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

	# EDUCATIONAL INFORMATION
	printf "$FORMAT_STRING_TWO_COL" "Education"
	printf "$FORMAT_STRING_TWO_COL" "Educational Background:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Passport:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Driver License:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Family Members:" "..." # 1..20 ? 
	printf "$FORMAT_STRING_TWO_COL" "Interests:" "${INTERESTS[$[RANDOM % ${#INTERESTS[@]}]]}"

	# FINANCIAL INFORMATION
	printf "\n%s\n"		        "Financial Information"
	printf "$FORMAT_STRING_TWO_COL" "Credit Card:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Expires:" "..."
	printf "$FORMAT_STRING_TWO_COL" "CVC2:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Paypal:" "..."
	printf "$FORMAT_STRING_TWO_COL%s" "Account Balance:" "$(( RANDOM % 9999 ))" "\$" #Local currency enhancement (based off of country residency)
	printf "$FORMAT_STRING_TWO_COL" "Prederred Payment:" "${PREFERRED_PAYMENT_TYPE[$[RANDOM % ${#PREFERRED_PAYMENT_TYPE[@]}]]}"

	# EMPLOYMENT INFORMATION
	printf "\n%s\n"		        "Employment"
	printf "$FORMAT_STRING_TWO_COL" "Company:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Occupation:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Monthly Salary:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Employment Status:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Company Size:" "${COMPANY_SIZE[$[RANDOM % ${#COMPANY_SIZE[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Industry Sector:" "${INDUSTRY_SECTOR[$[RANDOM % ${#INDUSTRY_SECTOR[@]}]]}"

	# OTHER INFORMATION	
	printf "\n%s\n"		        "Other Information"
	printf "$FORMAT_STRING_TWO_COL" "Favorite Color:" "${COLORS[$[RANDOM % ${#COLORS[@]}]]}"
	printf "$FORMAT_STRING_TWO_COL" "Vehicle:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Car License Plate:" "..." #country dependent
	printf "$FORMAT_STRING_TWO_COL" "GUID:" "..." # whats this?
	printf "$FORMAT_STRING_TWO_COL" "QR Code:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Movie:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Music Genre:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Song:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Book:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite Sport:" "..."
	printf "$FORMAT_STRING_TWO_COL" "Favorite TV Show:" "..." #same as below
	printf "$FORMAT_STRING_TWO_COL" "Favorite Movie Star:" "..." # same as below
	printf "$FORMAT_STRING_TWO_COL" "Favorite Singer:" "..." #list of singers, must be able to find that somewhere easily
	printf "$FORMAT_STRING_TWO_COL" "Favorite Food:" "..."
	printf "$FORMAT_STRING_TWO_COL%s%s" "Personality:" "$(shuf -n 3 traits.list)" # use the trait list, select a few
	printf "$FORMAT_STRING_TWO_COL" "Last Known IP:" "..." # Class A/B/C (think about it)
	printf "$FORMAT_STRING_TWO_COL" "Timezone:" "..."
	
	# LOGIC
	count=$(( count + 1 ))
	numberOfIdentities=$(( numberOfIdentities - 1 ))
	echo
done

## IDEAS FOR ENHANCEMENTS
# Based on statistics of leaving the country (for example at a specific age, such as expats) the FROM should equal RESIDENCY in nn% of the time, e.g. 93% should have FROM=RESIDENCY
