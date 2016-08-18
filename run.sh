function startup {
	clear
	echo "Welcome to Phone Number Lookup by Nick Lemke v1.0 9/17/16"
	echo "$(tput setaf 3)If there are any issues please contact dev$(tput sgr0)"
	sleep .5
	echo " "
	echo " "
	echo "What is the first three numbers? "
	read FIRSTTHREE
	echo "What are the middle three numbers? "
	read MIDDLETHREE
	echo "What are the last four numbers? "
	read LASTFOUR
	echo "$(tput setaf 3)Phone number entered was $FIRSTTHREE-$MIDDLETHREE-$LASTFOUR$(tput sgr0)"
}
function getinfo {
	cd areacodes
	#Search areacode.csv for the first 3 numbers in the phone number
	INFO=$(grep $FIRSTTHREE areacode.csv)
	#From the areacode.csv search finds the country
	COUNTRY=$(echo "$INFO" | awk -F "," '{print $2}')
	#From the areacode.csv search finds the state
	STATE=$(echo "$INFO" | awk -F "," '{print $3}')
	#From the areacode.csv search finds the state abbreviation
	ABB=$(echo "$INFO" | awk -F "," '{print $4}')
	#Makes the File that is searched using the middle 3 numbers provided
	SEARCHFILE="$FIRSTTHREE.csv"
	#Searches for the file
	if [ -f "$SEARCHFILE" ]; then
		#If its found it looks for the middle 3 numbers in the file
		INFOTWO=$(grep "$MIDDLETHREE" "$SEARCHFILE")
		#Searches for the city name
		CITYONE=$(echo "$INFOTWO" | awk -F "," '{print $2}')
		#Removes all the "s from the string and makes final CITY variable that is used in show
		CITY=$(echo "$CITYONE" | tr -d '"')
		COMPANY=$(echo "$INFOTWO" | awk -F "," '{print $4}')
		COUNTY=$(echo "$INFOTWO" | awk -F "," '{print $5}')
		USEAGE=$(echo "$INFOTWO" | awk -F "," '{print $6}')
		DATE=$(echo "$INFOTWO" | awk -F "," '{print $7}')

	else
		echo "$(tput setaf 1)Could not find $FIRSTTHREE areacode!$(tput sgr0)"
		echo "$(tput setaf 1)Please open issue and include the areacode$(tput sgr0)"
		exit
	fi
}
function capital {
	cd ../capital
	#Searches capitals.csv for the state name
	CAPITALINFO=$(grep "$STATE" "capitals.csv")
	#Finds the capital from capitals.csv
	CAPITAL=$(echo "$CAPITALINFO" | awk -F "," '{print $2}')
	#Start looking for zip code
	cd ../zips
	ZIPINFO=$(grep "$STATE" "zip.csv")
	echo "$ZIPINFO" >> tmp.csv
	ZIPONE=$(grep "$CITY" "tmp.csv")
	ZIP=$(echo "$ZIPONE" | awk -F "," '{print $1}')
	rm -r tmp.csv

}
function lastcheck {
	if [ -z "$COMPANY" ]; then
		COMPANY=$(echo "$(tput setaf 1)Not Found$(tput sgr0)")
		USEAGE=$(echo "$(tput setaf 1)Not Found$(tput sgr0)")
		DATE=$(echo "$(tput setaf 1)Not Found$(tput sgr0)")
	fi
	if [ -z "$CITY" ]; then
		COUNTY="Not Found"
		CITY=$(echo "$(tput setaf 1)Not Found$(tput sgr0)")
		ZIP=$(echo "$(tput setaf 1)Not Found$(tput sgr0)")
	fi

}
function show {
	echo " "
	echo " "
	echo "    Phone Information"
	echo "*************************"
	echo "Carrier = $COMPANY"
	echo "Date introduced = $DATE"
	echo "Useage = $USEAGE"
	echo "*************************"
	echo " "
	echo " "
	echo "     Call Geography"
	echo "*************************"
	echo "Country = $COUNTRY"
	echo "State = $STATE"
	echo "Abbreviation = $ABB"
	echo "Capital = $CAPITAL"
	echo "County = $COUNTY"
	echo "City = $CITY"
	echo "Zipcode = $ZIP"
	echo "*************************"
}
startup
getinfo
capital
lastcheck
show