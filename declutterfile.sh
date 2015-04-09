!/bin/bash
#Regular custom file declutter, deletes lines in a text file
#written by Murima

#prepare the color variables
RED=$(tput setaf 1 && tput bold)
GREEN=$(tput setaf 2 && tput bold)
STAND=$(tput sgr0)
BLUE=$(tput setaf 6 && tput bold)

echo $RED "#####################################"
echo "     Declutter file  version 1.0
             ::Murima (Tm)" 
echo $RED "#####################################" $STAND
echo "";

#this is the basic command of the whole program
#there has to be a suffix ".bak" immediately after the i option
#Its written in the man pages

#to see every output as its executed for debugging uncomment to turn on
set -x

#to get standard input from user using the first default variable
file=$1
#save a backup to ~/declutterbak incase something goes wrong *crosses fingers*
cp -n $file ~/Documents/declutterbak
echo "The number of lines of selected file is" 
 wc -l $file ;

#this 'before' variable will be used for comparison at end of program
before = `wc -l $file | cut -d " " -f1` 2> /dev/null

echo -e $GREEN "A..Do you want to delete a pattern \n B..A range of patterns example from 1 to 50 \n C..Take patterns from a file (press c) "
read answ

#option c
if [ $answ = "c" ]; then
echo $BLUE "Enter the name of file containing patterns to delete"
read filepatt

#delete patterns from file 
for i in $( cat ./"$filepatt" ); do
sed -i".bak" /$i/d "$file"> /dev/null ;
done
echo $BLUE "Done!"

else
#option b
#proper spacinf is critical in bash near braces  remember that
if [ $answ = "b" ]; then
echo $GREEN "What is the range of lines to delete"
echo $BLUE "start from"
read start
echo $BLUE "stop at"
read stop
#delete the lines selected

sed -i".bak"  "$start","$stop"d $file 
echo $BLUE "Done!"

else
#option a
if [ $answ = "a" ] ; then
echo $GREEN "How many patterns do you want me to match bro?"
echo "1, 2, 3, 6 or 9."
#read user input
echo "select" 
read opt
clear

#first option
echo $BLUE""
if [ $opt = "1" ] ; then
echo "Enter pattern to match"
read patt1

#delete the line containing the pattern and keep a backup .bak
sed -i".bak" /"$patt1"/d $file 2> /dev/null

else

#second option
echo $BLUE""
if [ $opt = "2" ] ; then
echo "Enter pattern 1. to match"
read patt1
echo "Enter pattern 2. to match"
read patt2


sed -i".bak" /"$patt1"/d $file 2> /dev/null
sed -i".bak" /"$patt2"/d $file 2> /dev/null


#third option
echo $BLUE""
if [ $opt = "3" ] ; then
#for loop that loops three times
for i in `seq 1 3`; do 
echo "Enter pattern to match"
#there is a variable error fix this later
read pat = patt$i 2> /dev/null

sed -i".bak" /"$pat"/d $file 2> /dev/null
done
else

#sixth option
echo $BLUE""
if [ $opt = "6" ] ; then
for i in `seq 1 6`; do
echo "Enter pattern ($i) to match" 
#there is a variable error
read pat = patt$i 2> /dev/null

sed -i".bak" /"$pat"/d $file 2> /dev/null
done
else

#ninth option
echo $BLUE""
if [ $opt = "9" ] ; then
for i in `seq 1 9`; do
echo "Enter pattern ($i)to match"
#there is a variable error
read pat = patt$i 2> /dev/null

sed -i".bak" /"$pat"/d $file 2> /dev/null
done

fi
fi
fi
fi
fi
fi
fi
fi
echo -e "\033[1;35m Number of lines deleted is"
after = `wc -l $file | cut -d " " -f1` 2> /dev/null

#exp can also be used
echo "$before $after"
ans= ` expr "$before" - "$after" ` 
echo -e  "\033[1;32m ->> $ans  " ;


