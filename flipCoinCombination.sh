headsCount=0
tailsCount=0
declare -A singletDictionary
declare -A doubletDictionary
function flipCoin(){
   flip=$1
   local result
   if [ $flip -eq 1 ]
   then
      result="H"
      headsCount=$(($headsCount+1))
   else
      result="T"
      tailsCount=$(($tailsCount+1))
   fi
   echo $headsCount","$tailsCount","$result
}

doubleCount=0
declare -A tempArray
j=1
for((i=1;i<=10;i++))
do
   flipResult="$( flipCoin $(($RANDOM%2)) )"
   headsCount=$( echo $flipResult | awk -F , '{print $1}')
   tailsCount=$( echo $flipResult | awk -F , '{print $2}')
   singletDictionary[$i]=$( echo $flipResult | awk -F , '{print $3}')
	tempArray[$doubleCount]=${singletDictionary[$i]}
	doubleCount=$(($doubleCount+1))
	if [ $doubleCount -eq 2 ]
	then
		doubleCount=0
		doubletDictionary[$j]=${singletDictionary[$(($i-1))]}${singletDictionary[$i]}
		j=$(($j+1))
	fi
done

echo ${doubletDictionary[@]}

HHCount=0
HTCount=0
THCount=0
TTCount=0

for doublet in ${doubletDictionary[@]}
do
	case $doublet in
			("HH")
				HHCount=$(($HHCount+1))
				;;
         ("HT")
            HTCount=$(($HTCount+1))
            ;;
         ("TH")
            THCount=$(($THCount+1))
            ;;
         ("TT")
            TTCount=$(($TTCount+1))
            ;;
	esac
done

percentageOfHH=$(($HHCount*200/10))
percentageofHT=$(($HTCount*200/10))
percentageOfTH=$(($THCount*200/10))
percentageofTT=$(($TTCount*200/10))
echo "percentage Of HH= "$percentageOfHH"%"
echo "percentage Of HT= "$percentageofHT"%"
echo "percentage Of TH= "$percentageOfTH"%"
echo "percentage Of TT= "$percentageofTT"%"
