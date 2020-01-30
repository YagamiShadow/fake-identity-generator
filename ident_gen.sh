#!/bin/bash
#shellcheck disable=SC2059
#shellcheck disable=SC2034
#shellcheck disable=SC2007
#Fix SC2007

# TEXT FORMATTING ----------------------------------------------------------------------------------------------------------
count=1
padding=24
page_with=80 # show multiple "pages" on the same screen. Use awk
FORMAT_STRING_TWO_COL="%-${padding}s%s %s %s %s %s\n"
FORMAT_STRING_THREE_COL="%-${padding}s%-${padding}s%-${padding}s %s %s %s\n"

# FILE LOCATIONS -----------------------------------------------------------------------------------------------------------
COUNTRY_LIST=countries.txt
MALE_NAMES=male_names.txt
FEMALE_NAMES=female_names.txt
PLACEHOLDER=null.txt

# VARIABLES ----------------------------------------------------------------------------------------------------------------
declare -A COUNTRY_PREFIX

# PROGRAM DATA -------------------------------------------------------------------------------------------------------------
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

# FUNCTIONS ----------------------------------------------------------------------------------------------------------------
function print_welcome {
cat << 'WELCOME'
███████╗ █████╗ ██╗  ██╗███████╗    ██╗██████╗ ███████╗███╗   ██╗████████╗██╗████████╗██╗   ██╗
██╔════╝██╔══██╗██║ ██╔╝██╔════╝    ██║██╔══██╗██╔════╝████╗  ██║╚══██╔══╝██║╚══██╔══╝╚██╗ ██╔╝
█████╗  ███████║█████╔╝ █████╗      ██║██║  ██║█████╗  ██╔██╗ ██║   ██║   ██║   ██║    ╚████╔╝ 
██╔══╝  ██╔══██║██╔═██╗ ██╔══╝      ██║██║  ██║██╔══╝  ██║╚██╗██║   ██║   ██║   ██║     ╚██╔╝  
██║     ██║  ██║██║  ██╗███████╗    ██║██████╔╝███████╗██║ ╚████║   ██║   ██║   ██║      ██║   
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝   ╚═╝      ╚═╝   
                                                                                               
         ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ████████╗ ██████╗ ██████╗           
        ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗          
        ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║   ██║   ██║   ██║██████╔╝          
        ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║   ██║   ██║   ██║██╔══██╗          
        ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║   ██║   ╚██████╔╝██║  ██║          
         ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝          
WELCOME
printf "\n" ""
printf "  %s %s %s\n" "[+]" "Author:" "SmokingCuke"
printf "  %s %s %s\n" "[+]" "Github:" "SmokingCuke"
printf "  %s %s %s\n\n\n" "[+]" "Description:" "This tool creates fake identities/personas that can be used when doing OSINT or for general OPSEC."
}
function luhn_validate { # <numeric-string>
	input_number=$1
	shift 1
	input_length=${#input_number}
	input_is_odd=1
	sum=0
	for((counter = input_length - 1; counter >= 0; --counter)) {
		digit=${input_number:$counter:1}
		if [[ $input_is_odd -eq 1 ]]; then
			sum=$(( sum + digit ))
		else
			sum=$(( sum + ( digit != 9 ? ( ( 2 * digit ) % 9 ) : 9 ) ))
		fi
		input_is_odd=$(( ! input_is_odd ))
	}
return $(( 0 != ( sum % 10 ) )) # NOTE: returning exit status of 0 on success
}
function luhn_generate_last_digit
{
	input_number=$1
	shift 1
	input_length=${#input_number}
	input_is_odd=1
	sum=0
	for((counter = input_length - 1; counter >= 0; --counter)) {
		digit=${input_number:$counter:1}
		if [[ $input_is_odd -eq 1 ]]; then
			sum=$(( sum + digit ))
		else
			sum=$(( sum + ( digit != 9 ? ( ( 2 * digit ) % 9 ) : 9 ) ))
		fi
		input_is_odd=$(( ! input_is_odd ))
	}
if [ $(( sum % 10 )) -eq 0 ]; 
then 
	sum=0;
else sum=$(( sum % 10 ));
fi

echo -n $(( 10 - sum  )) # NOTE: returning exit status of 0 on success
}

# SCRIPT PARAMETERS --------------------------------------------------------------------------------------------------------
input=${1}
compare_long="--help"
compare_flag="-h"
if [[ -z "${input}" ]]; then
	printf "%s\n%s\n" "Missing parameter - exiting." "Please specify number of identites to generate as a parameter.";
	exit ;
elif [[ "${input}" < 65536 ]]; then
	input_numberberOfIdentities=${1};
	print_welcome
elif [[ "${input}" == "${compare_long}" ]] || [ "${1}" = "${compare_flag}" ]; then
	printf "$FORMAT_STRING_THREE_COL" "Usage: ./ident_gen.sh <number>";
	printf "%20s%23s\t\t%s\n" "Short options:" "Long options:" "Description:";
	printf "\t$FORMAT_STRING_THREE_COL" "-h" "--help" "Prints this help";
	printf "\t$FORMAT_STRING_THREE_COL" "-V" "--version" "Prints version";						 #TODO
	printf "\t$FORMAT_STRING_THREE_COL" "-n" "--non-decimal-data" "Do not use decimals in output, round to nearest"; #TODO
	printf "\t$FORMAT_STRING_THREE_COL" "-p[=file]" "--profile[=file]" "Use a config file";				 #TODO
	exit;
else
	printf "%s" "Wrong parameters entered. Use the --help or -h flag for help on how to use the program.";
	exit;
fi

FORMAT_STRING_THREE_COL="%s %s %s\n"
# BUSINESS LOGIC -----------------------------------------------------------------------------------------------------------
while [ "$input_numberberOfIdentities" -ge 1 ]
do
	# PERSONAL INFORMATION
	credit_card_input_number="293828119299399" # Use function to generate last digit
	credit_card_input_number=$( luhn_generate_last_digit "${credit_card_input_number}" )
	if [ $? -eq 1 ]; then # 1 is error, 0 success
		luhn_validate "${credit_card_input_number}"
	else
		echo "Fault, exiting"
		exit;
	fi

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
	printf "$FORMAT_STRING_TWO_COL" "Credit Card:" "..." #Use the luhn mod10 algorithm provided by luhn.sh
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
	input_numberberOfIdentities=$(( input_numberberOfIdentities - 1 ))
	echo
done

## IDEAS FOR ENHANCEMENTS --------------------------------------------------------------------------------------------------
# Based on statistics of leaving the country (for example at a specific age, such as expats) the FROM should equal RESIDENCY in nn% of the time, e.g. 93% should have FROM=RESIDENCY
