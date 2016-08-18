function cleanup {
	echo "Phone-Number-Search cleanup"
	echo " "
	echo " "
	echo "Do you want to clear all recent searches? (y/n) "
	read SEARCHES
	if [ "$SEARCHES" = "y" ]; then
		rm -r ".searches"
		mkdir ".searches"
		cd ".searches"
		touch "list.txt"
		cd ..
		echo "Recent searches cleared"
	fi
	echo "Do you want to clear all exports? (y/n) "
	read EXPORTSYESNO
	if [ "$EXPORTSYESNO" = "y" ]; then
		rm -r "exports"
		mkdir "exports"
		echo "Exports cleared"
	fi
	echo "Goodbye"
}
pwd
cleanup