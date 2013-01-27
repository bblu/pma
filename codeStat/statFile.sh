###############################################
#funAnsFile()  by bblu at 2013-1-27           #
###############################################
#{
objFile=$1
objModl=$2

OAF=$TEMP/$NAME-$CURR
### the oraginal data
org=$(wc -l $objFile|awk '{print $1}')
Null=$(grep -c '^$' $objFile)
#funLog "org $org - Null $Null = $[$org - $Null]"

###initalize objFileect file ch tab & replace mutlspace
cat $objFile|tr -d "\t" > $OAF.tmp
sed 's/^[ \t]*//;s/[ \t]*$//;s/[[:space:]][[:space:]]*/ /g' $OAF.tmp > $OAF.std && rm $OAF.tmp

### delete Null line
sed -i '/^[\t]*$/d;/^\/\{2,3\}$/d' $OAF.std
stdl=$(wc -l $OAF.std|awk '{print $1}')

### anylias noteCode line
num=$(grep -c '^//.*[;){}]' $OAF.std)
###'
Null=$[$Null + $num]
#funLog "Null $[$Null - $num] + //code $num = $Null"
### delete note code
sed -i '/^\/\/.*[;){}]$/d' $OAF.std
[ -s $OAF.std ] || return 0
###anylias real note line
Note=0; allNote=0; stdNote=0; usaNote=0
grep '^//' $OAF.std > $OAF.not
if [ -s $OAF.not ];then
  allNote=$(wc -l $OAF.not|awk '{print $1}')
  stdNote=$(grep -c '^/// ' $OAF.not)
  usaNote=$(grep -c '^// ' $OAF.not)
  Note=$[$stdNote + $usaNote]
else
  allNote=o; stdNote=o; usaNote=o; Note=o
  rm $OAF.not
fi
###delete all Note line
sed '/^\/\//d' $OAF.std > $OAF.cod

###delete mutl note
if [ $TYPE -eq 0 ];then
  num=$(grep -c '^\\.' $OAF.cod)
  stdNote=$[$stdNote + $num]
  sed -i '/\/\*/{/\*\//d;:a;N;/\*\//d;ba};s,//.*,,' $OAF.cod
fi

###ans Exta code null Note #include {};
Exta=$[$allNote - $Note]
#funLog "Note $Note = std $stdNote + usa $usaNote Exta:$Exta"
num=$(grep -E -c '^#.|^[{}];*$|^namespace .|^class .' $OAF.cod)
Exta=$[$Exta + $num]
#funLog "Exta $Exta = extNote + extElse $num"

###ans real code
Code=$(grep -c '.*[);]$' $OAF.cod)
#'
#funLog "$FILE : $stdl - $[$Code + $Null + $Note + $Exta] = $Code + $Null + $Note + $Exta"
if [ $delFile -gt 0 ];then
  [ -s $OAF.cod ] && rm $OAF.cod
  [ -s $OAF.not ] && rm $OAF.not
  [ -s $OAF.std ] && rm $OAF.std
fi
#}
