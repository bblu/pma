### Main shell begin
if [ -z $1 -o -z$2 ];then
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