echo "Enter the name of database you want to connect "
read databaseName

 cd ..
cd data
if [[ -d "$databaseName" ]]
then
   cd $databaseName
   clear;
   echo "Welcome to $databaseName database :)"
#    . select2.sh  path of next
else
    cd ../connect
   echo "it doesn't exist!"
    options=("Enter agian name of Database" "Create one" "Exit")
	select val in "${options[@]}"
	do
		case $val in
            "Enter agian name of Database")
            clear ; . connect.sh ; clear ; break
            ;;
             "Create one")
            clear ; ../create/. createdb.sh  ; break
            ;;

             "Exit")
            clear ; exit
            ;;
			* ) echo "Invalid Choice"
		esac
	done
fi