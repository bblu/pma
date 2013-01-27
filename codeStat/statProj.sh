EXDIR='APi/'
IsLog=0
IsOut=0
IsIns=0
#dir svn version
DVP=0
#project stat var
PHALL=0; PHCODE=0; PHNOTE=0; PHNULL=0; PHFILE=0; PHMAXF=0; PHEXTA=0; PHCODEA=0; PHNOTEA=0; PHCODES=0; PHNOTES=0
PSALL=0; PSCODE=0; PSNOTE=0; PSNULL=0; PSFILE=0; PSMAXF=0; PSEXTA=0; PSCODEA=0; PSNOTEA=0; PSCODES=0; PSNOTES=0

#proj stat var
HALL=0; HCODE=0; HNOTE=0; HNULL=0; HFILE=0; HMAXF=0; HEXTA=0; HCODEA=0; HNOTEA=0; HCODES=0; HNOTES=0
SALL=0; SCODE=0; SNOTE=0; SNULL=0; SFILE=0; SMAXF=0; SEXTA=0; SCODEA=0; SNOTEA=0; SCODES=0; SNOTES=0

funEchoHeader()
{
  echo -e "\033[36m$PBD $PID-$PRJ upto r$TVB - [`date +%H:%M:%S`]\033[0m"
  echo -e "\033[31m$PBD,SVN,TYPE,VCPNAME,\tDIRVER\tHCODE\tHNOTE\tHEXTA\tHNULL\tHFILE\tHMAXF\tSCODE\tSNOTE\tSEXTA\tSNULL\tSFILE\tSMAXF\tSCODEA\tSCODES\033[0m"
  echo -e "DATE\t\tPSVN\tTYPE\tNAME\t\tPRJV\tHCODE\tHNOTE\tHEXTA\tHNULL\tHFILE\tHMAXF\tSCODE\tSNOTE\tSEXTA\tSNULL\tSFILE\tSMAXF\tHCODEA\tHCODES\tHNOTEA\tHNOTES\tSCODEA\tSCODES\tSNOTEA\tSNOTES" >> $OUT
}
funEchoVcp()
{
tab="\t"
len=`expr length $NAME`
if [ $len -gt 5 ];then
  tab=""
fi
 echo -e "\033[33m$PBD,$TVB,$TYPE,$NAME\t$tab$DVP\t$HCODE\t$HNOTE\t$HEXTA\t$HNULL\t$HFILE\t$HMAXF\t$SCODE\t$SNOTE\t$SEXTA\t$SNULL\t$SFILE\t$SMAXF\t$SCODEA\t$SCODES\033[0m"
}
funOutVcp()
{
tab=""
if [ $len -lt 8 ];then
  tab="\t"
fi
echo -e "$PBD\t$TVB\t$TYPE\t$NAME\t$tab$DVP\t$HCODE\t$HNOTE\t$HEXTA\t$HNULL\t$HFILE\t$HMAXF\t$SCODE\t$SNOTE\t$SEXTA\t$SNULL\t$SFILE\t$SMAXF\t$HCODEA\t$HCODES\t$HNOTEA\t$HNOTES\t$SCODEA\t$SCODES\t$SNOTEA\t$SNOTES" >> $OUT
}
funInsVcp()
{
#(\`id\`,\`pid\`, \`date\`, \`psvn\`,\`type\`, \`name\`, \`svn\`, \`hcode\`, \`hnote\`, \`hexta\`, \`hnull\`, \`hfile\`, \`hmax\`, \`scode\`, \`snote\`, \`sexta\`, \`snull\`, \`smax\`, \`sfile\`, \`hcodeadd\`, \`hcodesub\`, \`hnoteadd\`, \`hnotesub\`, \`scodeadd\`, \`scodesub\`, \`snoteadd\`, \`snotesub\`, \`team\`, \`note\`, \`company\`)
INSVAL="INSERT INTO \`zt_projcode\` VALUES (NULL, '$PID', '$PBD', '$TVB','$TYPE', '$NAME', '$DVP', '$HCODE', '$HNOTE', '$HEXTA', '$HNULL', '$HFILE', '$HMAXF', '$SCODE', '$SNOTE', '$SEXTA', '$SNULL', '$SMAXF', '$SFILE', '$HCODEA', '$HCODES', '$HNOTEA', '$HNOTES', '$SCODEA', '$SCODES', '$SNOTEA', '$NOTES','0', '', '1');"
echo $INSVAL >> $INS
#"$MYSQL" -hlocalhost -uadmin zentao -e "$INSVAL"
}

funEchoProject()
{
  echo -e "\033[31m$PBD,$TVB,all,ProjectAll,\t$TVB\t$PHCODE\t$PHNOTE\t$PHEXTA\t$PHNULL\t$PHFILE\t$PHMAXF\t$PSCODE\t$PSNOTE\t$PSEXTA\t$PSNULL\t$PSFILE\t$PSMAXF\t$PSCODEA\t$PSCODES\\033[0m"
}
funOutProject()
{
  echo -e "$PBD\t$TVB\tALL*\tPROJECT*\t\t$TVB*\t$PHCODE*\t$PHNOTE*\t$PHEXTA*\t$PHNULL*\t$PHFILE*\t$PHMAXF*\t$PSCODE*\t$PSNOTE*\t$PSEXTA*\t$PSNULL*\t$PSFILE*\t$PSMAXF*\t$PHCODEA*\t$PHCODES*\t$PHNOTEA*\t$PHNOTES*\t$PSCODEA*\t$PSCODES*\t$PSNOTEA*\t$PSNOTES*" >> $OUT
}

funLog()
{
if [ $IsLog -gt 0 ];then
  echo $1
fi
}
funZeroNum()
{
  HALL=0; HCODE=0; HNOTE=0; HNULL=0; HFILE=0; HMAXF=0; HEXTA=0; HCODEA=0; HNOTEA=0; HCODES=0; HNOTES=0
  SALL=0; SCODE=0; SNOTE=0; SNULL=0; SFILE=0; SMAXF=0; SEXTA=0; SCODEA=0; SNOTEA=0; SCODES=0; SNOTES=0
}
funZeroProject()
{
  PHALL=0; PHCODE=0; PHNOTE=0; PHNULL=0; PHFILE=0; PHMAXF=0; PHEXTA=0; PHCODEA=0; PHNOTEA=0; PHCODES=0; PHNOTES=0
  PSALL=0; PSCODE=0; PSNOTE=0; PSNULL=0; PSFILE=0; PSMAXF=0; PSEXTA=0; PSCODEA=0; PSNOTEA=0; PSCODES=0; PSNOTES=0
}
funZeroDelta()
{
  PHCODEA=0; PHNOTEA=0; PHCODES=0; PHNOTES=0
  PSCODEA=0; PSNOTEA=0; PSCODES=0; PSNOTES=0
}
funUpInc()
{
HFILE=$[$HFILE + $fileN]
HALL=$[$HALL + $stdl]
HNULL=$[$HNULL + $null]
HNOTE=$[$HNOTE + $note]
HCODE=$[$HCODE + $code]
HEXTA=$[$HEXTA + $exta]
if [ $maxf -gt $HMAXF ];then
  HMAXF=$[$maxf]
fi
}
funUpSrc()
{
SFILE=$[$SFILE + $fileN]
SALL=$[$SALL + $stdl]
SNULL=$[$SNULL + $null]
SNOTE=$[$SNOTE + $note]
SCODE=$[$SCODE + $code]
SEXTA=$[$SEXTA + $exta]
if [ $maxf -gt $SMAXF ];then
  SMAXF=$[$maxf]
fi
}
funUpProject()
{
PHFILE=$[$PHFILE + $HFILE]
PHALL=$[$PHALL + $HALL]
PHNULL=$[$PHNULL + $HNULL]
PHNOTE=$[$PHNOTE + $HNOTE]
PHCODE=$[$PHCODE + $HCODE]
PHEXTA=$[$PHEXTA + $HEXTA]
if [ $HMAXF -gt $PHMAXF ];then
  PHMAXF=$[$HMAXF]
fi
PHNOTEA=$[$PHNOTEA + $HNOTEA]
PHCODEA=$[$PHCODEA + $HCODEA]
PHNOTES=$[$PHNOTES + $HNOTES]
PHCODES=$[$PHCODES + $HCODES]

PSFILE=$[$PSFILE + $SFILE]
PSALL=$[$PSALL + $SALL]
PSNULL=$[$PSNULL + $SNULL]
PSNOTE=$[$PSNOTE + $SNOTE]
PSCODE=$[$PSCODE + $SCODE]
PSEXTA=$[$PSEXTA + $SEXTA]
if [ $SMAXF -gt $PSMAXF ];then
  PSMAXF=$[$SMAXF]
fi
PSNOTEA=$[$PSNOTEA + $SNOTEA]
PSCODEA=$[$PSCODEA + $SCODEA]
PSNOTES=$[$PSNOTES + $SNOTES]
PSCODES=$[$PSCODES + $SCODES]
#funEchoProject
}

funAnsDir()
{
dirVer=$(svn info $raw | grep 'Last Changed Rev:'|awk '{print $4}')
if [ $dirVer -gt $DVP ];then
  DVP=$[$dirVer]
fi

files=$(find ./$raw -name '*.h' -type f -exec stat -c "%s %n" {} \;|sort -nr|grep -E -v '$EXDIR'|awk '{print $2}')
fileN=$(echo $files|awk '{print NF}')
#fileN=$(find $LOCAL/$raw -name '*.h'|wc -l)
#echo $fileN:$files
if [ $fileN -gt 0 ];then
  maxfile=$(echo $files|awk '{print $1}')
  maxf=$(wc -l $maxfile|awk '{print $1}')
  cat $files > f.all
  if [ -f f.all ];then
    funAnsCode f.all 0
  fi
  funUpInc
  if [ $LASTVB -gt 0 ];then 
    funDiffHpp
  fi

fi


files=$(find ./$raw -name '*.cpp' -type f -exec stat -c "%s %n" {} \;|sort -nr|grep -E -v $EXDIR|awk '{print $2}')
fileN=$(echo $files|awk '{print NF}')
#echo $fileN:$files
if [ $fileN -gt 0 ];then 
  maxfile=$(echo $files|awk '{print $1}')
  maxf=$(wc -l $maxfile|awk '{print $1}')
  cat $files > f.all
  if [ -f f.all ];then
    funAnsCode f.all 1
  fi
  funUpSrc
  if [ $LASTVB -gt 0 ];then 
    funDiffCpp
  fi
fi
}

# D:/svn_bkup/zScenes

if [ -z $1 -o -z $2 ];then
  echo "please input the statictics proj name and begin date..."
  exit 1
fi

PRJ=$1
#ProjectBeginDate
PBD=`date -d "$2" +%Y-%m-%d`
#WeekBeginDate
WED=`date -d "$PBD UTC +8 day" +%Y-%m-%d`
#ProjectEndDate
PED=`date +%Y-%m-%d`

END=$3
if [ -n $END ];then
  PED=`date -d "$3" +%Y-%m-%d`
fi

if [ "$PRJ" = "zMap" ];then
  PID=1
elif [ "$PRJ" = "zScenes" -o "$PRJ" = "ZoomwaySceneEngine" ];then
  PID=3
elif [ "$PRJ" = "zGIS" ];then
  PID=7
elif [ "$PRJ" = "zWorld" ];then
  PID=9
fi
echo "$PRJ PID=$PID"

TRUNK=http://sysmanager:81/svn/$PRJ/trunk
LOCAL=d:/zoomway_ci/data/svnCode/$PRJ

U=Hudson 
P=hudson 
OUT="../temp/$PRJ-Code.log"
INS="../temp/$PRJ-Inst.sql"
MYSQL="C:/Program Files/BitNami Redmine Stack/mysql/bin/mysql.exe"

DIR="d:/zoomway_ci/data/svnCode/temp/$PBD"
if [ ! -d "$DIR" ]; then
  mkdir $DIR
fi

if [ ! -d "$LOCAL" ]; then
  mkdir $LOCAL
fi
  cd $LOCAL
if [ `ls $LOCAL|wc -l` -lt 1 ];then
  BB=`date -d "$PBD UTC -1 day" +%Y-%m-%d`
  echo "svn co -r{$BB} $TRUNK $LOCAL"
  svn co -r{$BB} $TRUNK $LOCAL --username $U --password $P > $DIR/$PRJ-co.log
fi

#WeekBeginTime
WBT=`date -d "$PBD" +%s`
#ProjectEndTime
PET=`date -d "$PED" +%s`
LASTVB=0

while [ $WBT -le $PET ];do

TVS=$(svn log -r{$WED}:{$PBD} $TRUNK --username $U --password $P |grep [r][0-9]|tr -d r|awk '{print $1}')
if [ -z "$TVS" ];then
  funEchoHeader
  funZeroDelta
  TVB=$LASTVB
  TVE=$LASTVB
else

TVB=$(echo $TVS|awk '{print $NF}')
TVE=$(echo $TVS|awk '{print $1}')

funZeroProject
funEchoHeader

svn update -r$TVB > $DIR/$PRJ-up-$TVB.log
CFG=$PRJ.cfg
if [ ! -f $CFG ];then
  CFG="../bkup/$PRJ.cfg"
  if [ ! -f $CFG ];then
    echo "Not found config file:$PRJ.cfg"
    exit 0
  else
    echo "Use bkup cfg:$CFG"
  fi
fi

#vcp begin
while read VCP;do
funZeroNum
#echo $VCP
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

#if [ -z $TVS ];then
fi

funEchoProject
funOutProject

LASTVB=$TVB

PBD=`date -d "$PBD UTC +7 day" +%Y-%m-%d`
WED=`date -d "$PBD UTC +8 day" +%Y-%m-%d`
WBT=`date -d "$PBD" +%s`
#while date
done
echo -e "\033[36m$PBD $PRJ upto r$TVB - [`date +%H:%M:%S`]\033[0m"