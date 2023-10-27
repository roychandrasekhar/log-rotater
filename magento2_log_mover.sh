#!/bin/bash
PATH="/home/bitnami/htdocs/"
TEMPPATH="/tmp/d2e/"
/bin/mkdir -p $TEMPPATH

for eachlogfile in "system" "exception" "debug" "TISU";
  do
  oldlog=$PATH"var/log/$eachlogfile.log"
  echo "Processing file $oldlog"
  if test -f $oldlog ; then
    newlog=$PATH"var/log/"$eachlogfile"1.log"
    echo $newlog " file rename in same dir"
    /bin/mv $oldlog $newlog
  fi

  for i in 3 2 1
  do
    LASTFILE=$PATH"var/log/$eachlogfile$i.log"
    echo "Processing file $LASTFILE"
    if test "$i" -eq "3" ; then
      now=$(/bin/date +"%d_%m_%Y_%s")
      if test -f $LASTFILE; then
         newlog=$TEMPPATH"$eachlogfile"$now".log"
         /bin/mv $LASTFILE $newlog
         echo "File move from: $LASTFILE to: $newlog"
      fi
    else
      if test -f $LASTFILE ; then
        oldlog=$PATH"var/log/$eachlogfile$i.log"
        newlog=$PATH"var/log/$eachlogfile$(($i+1)).log"
        /bin/mv $oldlog $newlog
        echo "File rename from: $oldlog to: $newlog"
      fi
    fi
  done

done
