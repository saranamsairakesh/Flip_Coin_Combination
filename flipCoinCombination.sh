declare -A singletDictionary
declare -A doubletDictionary
headsCount=0
tailsCount=0

function flipCoin(){
   if [ $1 -eq 1 ]
   then
      result="H"
      headsCount=$(($headsCount+1))
   else
      result="T"
      tailsCount=$(($tailsCount+1))
   fi
   echo $headsCount","$tailsCount","$result
}

for((i=1;i<=10;i++))
do
   flipResult="$( flipCoin $(($RANDOM%2)) )"
   headsCount=$( echo $flipResult | awk -F , '{print $1}')
   tailsCount=$( echo $flipResult | awk -F , '{print $2}')
   singletDictionary[$i]=$( echo $flipResult | awk -F , '{print $3}')
done

for((i=1;i<=9;i++))
do
   doubletDictionary[$i]=${singletDictionary[$i]}${singletDictionary[$(($i+1))]}
done

percentageOfHeads=$(($headsCount*100/10))
percentageofTails=$(($tailsCount*100/10))
echo "Percentage of Heads= "$percentageOfHeads"%"
echo "Percentage of Tails= "$percentageofTails"%"

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

percentageOfHH=$(($HHCount*100/9))
percentageofHT=$(($HTCount*100/9))
percentageOfTH=$(($THCount*100/9))
percentageofTT=$(($TTCount*100/9))
echo "percentage Of HH= "$percentageOfHH"%"
echo "percentage Of HT= "$percentageofHT"%"
echo "percentage Of TH= "$percentageOfTH"%"
echo "percentage Of TT= "$percentageofTT"%"

