#!/bin/bash
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

declare -A singletSort

if [ $headsCount -ge $tailsCount ]
then
	singletSort[0]="H"
	singletSort[1]="T"
else
	singletSort[0]="T"
   singletSort[1]="H"
fi

echo "Sorted Singlet= "${singletSort[@]}

for((i=1;i<=9;i++))
do
   doubletDictionary[$i]=${singletDictionary[$i]}${singletDictionary[$(($i+1))]}
done

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

declare -A doubletCountSort
declare -A doubletSort
doubletCountSort[0]=$HHCount
doubletCountSort[1]=$HTCount
doubletCountSort[2]=$THCount
doubletCountSort[3]=$TTCount
doubletSort[0]="HH"
doubletSort[1]="HT"
doubletSort[2]="TH"
doubletSort[3]="TT"

for((i=0;i<4;i++))
do
	for((j=0;j<((4-$i-1));j++))
	do
		if [ ${doubletCountSort[$j]} -lt ${doubletCountSort[$(($j+1))]} ]
		then
			temp1=${doubletCountSort[$(($j+1))]}
			doubletCountSort[$(($j+1))]=${doubletCountSort[$j]}
			doubletCountSort[$j]=$temp1

			temp2=${doubletSort[$(($j+1))]}
         doubletSort[$(($j+1))]=${doubletSort[$j]}
         doubletSort[$j]=$temp2
		fi
	done
done

echo "Sorted Doublet= "${doubletSort[@]}

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

declare -A tripletCountSort
declare -A tripletSort
tripletCountSort[0]=$HHHCount
tripletCountSort[1]=$HHTCount
tripletCountSort[2]=$HTHCount
tripletCountSort[3]=$THHCount
tripletCountSort[4]=$TTTCount
tripletCountSort[5]=$TTHCount
tripletCountSort[6]=$THTCount
tripletCountSort[7]=$HTTCount
tripletSort[0]="HHH"
tripletSort[1]="HHT"
tripletSort[2]="HTH"
tripletSort[3]="THH"
tripletSort[4]="TTT"
tripletSort[5]="TTH"
tripletSort[6]="THT"
tripletSort[7]="HTT"

for((i=0;i<8;i++))
do
	for((j=0;j<((8-$i-1));j++))
	do
		if [ ${tripletCountSort[$j]} -lt ${tripletCountSort[$(($j+1))]} ]
		then
			temp1=${tripletCountSort[$(($j+1))]}
			tripletCountSort[$(($j+1))]=${tripletCountSort[$j]}
			tripletCountSort[$j]=$temp1

			temp2=${tripletSort[$(($j+1))]}
         tripletSort[$(($j+1))]=${tripletSort[$j]}
         tripletSort[$j]=$temp2
		fi
	done
done

echo "Sorted Triplet= "${tripletSort[@]}
