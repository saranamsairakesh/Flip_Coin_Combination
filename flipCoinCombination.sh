headsCount=0
tailsCount=0
declare -A singletDictionary
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

for((i=1;i<=10;i++))
do
   flipResult="$( flipCoin $(($RANDOM%2)) )"
   headsCount=$( echo $flipResult | awk -F , '{print $1}')
   tailsCount=$( echo $flipResult | awk -F , '{print $2}')
   singletDictionary[$i]=$( echo $flipResult | awk -F , '{print $3}')
done

echo ${singletDictionary[@]}
