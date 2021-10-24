if [[ -z ${1} ]]
then
	echo "Usage jrun [main_class_title] [path_to_drivers (default = 0)]"
	exit 1
elif [[ (${1} && -z ${2}) || (${1} && ${2} == '0') ]]
then
	javac *.java

	echo -e "\nStarting program...\n"	
	java $1

	rm *.class
elif [[ ${1} && ${2} ]] 
then
	all_drivers=".:"

	for driver in $(find ${2} -name "*.jar" -printf "%f\n")
	do
		all_drivers=${all_drivers}${2}${driver}':'
		echo "Added driver: ${driver}"		
	done

	javac -cp $all_drivers *.java

	echo -e "\nStarting program...\n"
	java -cp $all_drivers $1

	rm *.class

else
	echo "Something went wrong"
	exit 2
fi