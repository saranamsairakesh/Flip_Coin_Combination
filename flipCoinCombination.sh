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

for((i=1;i<=8;i++))
do
   tripletDictionary[$i]=${singletDictionary[$i]}${singletDictionary[$(($i+1))]}${singletDictionary[$(($i+2))]}
done

HHHCount=0
HHTCount=0
HTHCount=0
THHCount=0
TTTCount=0
TTHCount=0
THTCount=0
HTTCount=0

for triplet in ${tripletDictionary[@]}
do
   case $triplet in
         ("HHH")
            HHHCount=$(($HHHCount+1))
            ;;
         ("HHT")
            HHTCount=$(($HHTCount+1))
            ;;
         ("HTH")
            HTHCount=$(($HTHCount+1))
            ;;
         ("THH")
            THHCount=$(($THHCount+1))
            ;;
         ("TTT")
            TTTCount=$(($TTTCount+1))
            ;;
         ("TTH")
            TTHCount=$(($TTHCount+1))
            ;;
         ("THT")
            THTCount=$(($THTCount+1))
            ;;
         ("HTT")
            HTTCount=$(($HTTCount+1))
            ;;
   esac
done

percentageOfHHH=$(($HHHCount*100/8))
percentageofHHT=$(($HHTCount*100/8))
percentageOfHTH=$(($HTHCount*100/8))
percentageofTHH=$(($THHCount*100/8))
percentageOfTTT=$(($TTTCount*100/8))
percentageofTTH=$(($TTHCount*100/8))
percentageOfTHT=$(($THTCount*100/8))
percentageofHTT=$(($HTTCount*100/8))
echo "percentage Of HHH= "$percentageOfHHH"%"
echo "percentage Of HHT= "$percentageofHHT"%"
echo "percentage Of HTH= "$percentageOfHTH"%"
echo "percentage Of THH= "$percentageofTHH"%"
echo "percentage Of TTT= "$percentageOfTTT"%"
echo "percentage Of TTH= "$percentageofTTH"%"
echo "percentage Of THT= "$percentageOfTHT"%"
echo "percentage Of HTT= "$percentageofHTT"%"
