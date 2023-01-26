#!/bin/bash

# validation 
function notValid(){
    if ! [[ $1 =~ ^[a-zA-Z]+$ ]]
    then
        echo 'Wrong name. Only a-zA-Z characters are allowed'
        return 0
    else
        return 1

    fi
}   

function validName(){
    if [[ $1 =~ ^[a-zA-Z]+$  ]]
    then
        return 0
    else
        return 1
    fi
}

# a function that will check is the 
function checkTypeofInt(){
    # $1 -> for val name
    if [[ $1 =~ ^[0-9]+$ ]]
    then 
        return 1
    else 
        return 0
    fi
}

function checkTypeofSTring(){
   if  [[ $1 =~ ^[a-zA-Z]+$ ]]
   then
        return 0
    else
        return 1
    fi
}

# check if table file exists 
function duplicatedTable(){
    if [[ -f $1 ]] 
    then
        echo "duplicated file name "
        return 0
    else 
        return 1
    fi

}

# get& handel table name -> keep on reading till we get a valid name
function getTableName(){
    read -p " enter a valid table name " table_name
    while notValid $table_name 
    do 
        read -p "PLeaze enter a valid user name " table_name
    done
}

#a functions that handel pk constrain 
function CreatePrimaryKey(){
    read -p "write (pk) column name : " col_name
    if validateColName $col_name 
    then
        colType+=("int")
    else 
        echo "not a valid column name "
        CreatePrimaryKey
    fi 
}

colHeaders=()
colType=()

function validateColName(){
    # if a valid col name -> append it colHeaders array
    if validName $1
    then
        colHeaders+=($1)
        return 0
    else
        return 1
    fi 
}

# a function that will handel creating col along with its types
function CreateColumns(){
    typeset -i numOfCols
    
    read -p "write your number of columns : " numOfCols
    let ColsNumber=$numOfCols+1
    echo $ColsNumber
    while [ $numOfCols -gt 0 ]
    do
        read -p "write column name : " col_name
        
        if validateColName $col_name 
        then # get  col type
            echo "chooce column datatype : "
                select datatype in "int" "string"
                do
                    case $datatype in
                        "int" )
                            colType+=($datatype)
                            break;;

                        "string" ) 
                            colType+=($datatype)
                            break;;
                    esac
                done
                let numOfCols-=1
       
        else 
             echo "not a valid column name !"
        fi 
        
    done

}


# to handel file for table cols records and metadata file
function CreateTablefiles(){

    #touch $table_name
    
    echo "$table_name:$ColsNumber"  # >> $metaFile
    #colHeaders colType
    ColNumber=0
    while [ ! $ColsNumber -eq $ColNumber ]
    do
        echo "${colHeaders[$ColNumber]}:$(( $ColNumber+1)):${colType[$ColNumber]}" # >> $metaFile
        let ColNumber+=1

    done        
    
}

# start running rigth here
getTableName 

# if validName :
# then
#     table_name=$1
# else :
#     getTableName $1


echo $table_name


if duplicatedTable $table_name
then
    echo "dup"
    getTableName
else
    CreatePrimaryKey #get pk first
    CreateColumns  # handel the rest of cols
    CreateTablefiles  #touch file
    echo "table created successfully"
fi

#CreateColumns 
# echo colsname is ${colHeaders[@]}
# echo ${colType[@]}
