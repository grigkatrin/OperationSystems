
mkdir -p "/home/$USER/.trash";

if [ $# -lt 1 ]
then
	echo "Usage: trash.sh [OPTIONS]... [FILE]..."
	exit 1
fi

while getopts ":helr:" option
do
	case $option in
		h)
echo "Usage: trash.sh [OPTIONS]... [FILE]...
Sending a specified FILEs to the $trash_path
OPTIONS:
	-h display this help and exit
	-e empty trash
	-l list contents
	-r FILENAME restore the specified FILENAME"
		exit 0;;
		e)
		count=$(ls "/home/$USER/.trash" | wc -l)
			if [ $count -gt 0 ] 
			then
				for file in "/home/$USER/.trash/*"
				do
					rm -r $file
				done
			else
				echo "nothing to delete"
			fi
		exit 0;;
		l)
		count=$(ls "/home/$USER/.trash" | wc -l)
			if [ $count -gt 0 ] 
			then
				ls "/home/$USER/.trash"
			else
				echo "trash is empty"
			fi
		exit 0;;
		r)
		for file in $@ 
			do
				if [ -e "/home/$USER/.trash/$file" ]
				then
					if [ -e $file ]
					then
						echo "Error: $file is already exist"
					else
						mv "/home/$USER/.trash/$file" $PWD
					fi
				fi
			done
		exit 0;;
		*)echo "unknown comand";;
esac
done

for file in $@ 
	do
		if [ -e $file ]
		then
			counter=0
			if [ -e "/home/$USER/.trash/$file_name" ]
			then
				while [[ -e "/home/$USER/.trash/$file_name" ]]; do
					let "counter++"
					file_name="$file.$counter"
				done
			fi
			file_name="$file.$counter"
			mv $file "/home/$USER/.trash/$file_name" 
		fi
	done
