#!/bin/bash
# SMS via playSMS Gateway

###========================================###
# Nico Hartung <nicohartung1@googlemail.com> #
###========================================###

###===========###
##  Variables  ##
###===========###

DATE=`date +%Y-%m-%d`
NOW=`date +%Y-%m-%d_%H-%M`

NAME="playsms-webservices"
LOGFILE=/tmp/${NAME}_${DATE}.log

CURL="/usr/bin/curl -g -s -k"
HOSTSUBJECT="$NOTIFY_NOTIFICATIONTYPE $NOTIFY_HOSTALIAS"
SERVICESUBJECT="$NOTIFY_NOTIFICATIONTYPE $NOTIFY_HOSTALIAS $NOTIFY_SERVICEDESC"

# Debug
DEBUG=0                                 # 0=disable / 1=enable
#NOTIFY_CONTACTPAGER="0049123456789"    # for testing
#HOSTSUBJECT="Testing"                  # for testing

# playSMS Gateway
PLAYSMSUSER="USERID?"
PLAYSMSPW="TOKEN?"
PLAYSMSURL="WEBSERVICE-URL?"


###========###
##  Script  ##
###========###

### contactpager
if [[ -z $NOTIFY_CONTACTPAGER ]]; then
    if [ "$DEBUG" = "1" ]; then
        echo "$NOW - FAIL (no pagernumber)"  >> $LOGFILE
        exit 1
    else
        exit 1
    fi
fi

### service notification
if [ "$NOTIFY_WHAT" = "SERVICE" ]; then
    # without comment
    if [[ -z $NOTIFY_NOTIFICATIONCOMMENT ]]; then
        MESSAGE=`echo "$SERVICESUBJECT - $NOTIFY_SERVICEOUTPUT" | sed 's/ /%20/g'`
    # with comment
    else
        MESSAGE=`echo "$SERVICESUBJECT - <$NOTIFY_NOTIFICATIONCOMMENT> (by $NOTIFY_NOTIFICATIONAUTHOR) $NOTIFY_SERVICEOUTPUT" | sed 's/ /%20/g'`
    fi
### host notification
else
    # without comment
    if [[ -z $NOTIFY_NOTIFICATIONCOMMENT ]]; then
        MESSAGE=`echo "$HOSTSUBJECT - $NOTIFY_HOSTOUTPUT" | sed 's/ /%20/g'`
    # with comment
     else
        MESSAGE=`echo "$HOSTSUBJECT - <$NOTIFY_NOTIFICATIONCOMMENT> (by $NOTIFY_NOTIFICATIONAUTHOR) $NOTIFY_HOSTOUTPUT " | sed 's/ /%20/g'`
    fi
fi

### send message
if [ "$MESSAGE" != "%20%20-%20" ]; then
    COMMAND="$CURL $PLAYSMSURL?app=ws&u=$PLAYSMSUSER&h=$PLAYSMSPW&op=pv&to=$NOTIFY_CONTACTPAGER&msg=$MESSAGE"
    if [ "$DEBUG" = "1" ]; then
        echo "$NOW - $COMMAND"          >> $LOGFILE
        env | grep NOTIFY_ | sort       >> $LOGFILE
        $COMMAND                        >> $LOGFILE
    else
        $COMMAND                        >> /dev/null
    fi
else
    if [ "$DEBUG" = "1" ]; then
        echo "$NOW - FAIL (empty message)"  >> $LOGFILE
        exit 1
    else
        exit 1
    fi
fi
