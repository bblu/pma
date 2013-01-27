###############################################
#funDiffFile()  by bblu at 2013-1-27          #
###############################################
funDiffHpp()
{
  #difLog=./../diff/$NAME-hpp-$dirVer.log
  difLog=$DIR/$PRJ-df-$TVB-$NAME-hpp-$dirVer.log
  svn diff -r$LASTVB:$dirVer $files|grep '^[-+][^#].'|grep -v '^[-+]\{3\}'|grep -v '^[-+] *#' > $difLog
  if [ -f $difLog ];then
     alla=$(grep -c '^+.' $difLog)
    notea=$(grep -c '^+.*//' $difLog)
    codea=$[$alla - $notea]
    HNOTEA=$[$HNOTEA + $notea]
    HCODEA=$[$HCODEA + $codea]
     alls=$(grep -c '^-.' $difLog)
    notes=$(grep -c '^-.*//' $difLog)
    codes=$[$alla - $notes]
    HNOTES=$[$HNOTES + $notes]
    HCODES=$[$HCODES + $codes]
    #rm ./$difLog
    #echo -e "$raw :\t$HCODEA\t$HCODES\t$HNOTEA\t$HNOTES" 
  fi
}
funDiffCpp()
{
  #difLog=./../diff/$NAME-cpp-$dirVer.log
  difLog=$DIR/$PRJ-df-$TVB-$NAME-cpp-$dirVer.log
  svn diff -r$LASTVB:$dirVer $files|grep '^[-+][^#].'|grep -v '^[-+]\{3\}'|grep -v '^[-+] *#' > $difLog
  if [ -f $difLog ];then
     alla=$(grep -c '^+.' $difLog)
    notea=$(grep -c '^+.*//' $difLog)
    codea=$[$alla - $notea]
    SNOTEA=$[$SNOTEA + $notea]
    SCODEA=$[$SCODEA + $codea]
     alls=$(grep -c '^-.' $difLog)
    notes=$(grep -c '^-.*//' $difLog)
    codes=$[$alls - $notes]
    SNOTES=$[$SNOTES + $notes]
    SCODES=$[$SCODES + $codes]
    #rm ./$difLog
    #echo -e "$raw :\t$SCODEA\t$SCODES\t$SNOTEA\t$SNOTES" 
  fi
}