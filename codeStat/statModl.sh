objModl=$1
mdlConf=$objModl.cfg
if [ ! -f $mdlConf ];then
  mdlConf="../bkup/$mdlConf"
  if [ ! -f $mdlConf ];then
    echo "Not found config file:$mdlConf"
    exit 1
  else
    echo "Use bkup cfg:$mdlConf"
  fi
fi

#vcp begin
while read VCP;do
i=0
for raw in $VCP;do

if [ $i -eq 0 ];then
  TYPE=$raw
elif [ $i -eq 1 ];then
  NAME=$raw
elif [ $i -gt 1 ];then
  if [ ! -d "$LOCAL/$raw" ]; then
    continue
  fi
  funAnsDir $raw

fi
((i++))
done

if [ $SFILE -eq 0 ]; then
  continue
fi

funEchoVcp
funOutVcp
funInsVcp
funUpProject

#while read VCP;do
done < "$CFG"