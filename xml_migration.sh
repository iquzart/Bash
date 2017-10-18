#!/bin/bash
# +==========================================================================================+ |
# |                                                                                            |
# | $Id: MIGRATIONSCRIPT.sh$                                                                   |
# |                                                                                            |
# |Description: This Script will mograte the XML                                               |
# |                                                                                            |
# |                                                                                            |
# |Usage: Call this script like this:                                                          |
# | MIGRATIONSCRIPT.sh <Apps Login> <Host Name>  <DB SID> <DB PORT>                            |
# |for example:                                                                                |
# | MIGRATIONSCRIPT.sh apps/apps localhost.oracle.com 1522 SID OR SERVICENAME                  |
# |                                                                                            |
# |Change Record:                                                                              |
# |===============                                                                             |
# |Version   Date         Author             Remarks                                           |
# |=======   ==========   =============      ===============                                   |
# |DRAFT1A   14-Jul-2015  Jude Felix         modified on 17-Oct-2017 by Meraas Infra Team      |
# |                                          * Disabled sqlplus /nolog                         |
# |                                          * Disabled Password visibility                    |
# |                                          * Exit on incorrect login credentials format      |
# |============================================================================================+

CUR_DIR=`pwd`

APPS_LOGIN_ID="$1"
HOST="$2"
PORT="$3"
SID="$4"
SERVICE_NAME="$5"

TIME_STAMP=`date +%Y%m%d.%H%M`
PREFIX_NAME="XXCUST_MIGRATION_LOG"
LOG_FILE_TMP=`echo $PREFIX_NAME$TIME_STAMP".log"`
LOG_FILE_PATH=$CUR_DIR
LOG_FILE=`echo $LOG_FILE_PATH"/"$LOG_FILE_TMP`
echo "Log File Name" $LOG_FILE


# *******************************************************************
#  Check if APPS Login Id is entered else prompt to get it
# *******************************************************************

if [[ $APPS_LOGIN_ID == */* ]];then
  APPS_LOGIN=`echo $APPS_LOGIN_ID | cut -d"/" -f1`
  APPS_PWD=`echo $APPS_LOGIN_ID | cut -d"/" -f2`
elif [ "$APPS_LOGIN_ID" = "" ];then
  echo "Enter App Login ID: "
  read APPS_LOGIN
  echo  "Enter App Login Password: "
  APPS_PWD=''
    while IFS= read -r -s -n1 char; do
      [[ -z $char ]] && { printf '\n'; break; }
         if [[ $char == $'\x7f' ]]; then
              [[ -n $APPS_PWD ]] && APPS_PWD=${APPS_PWD%?}
              printf '\b \b'
            else
             APPS_PWD+=$char
             printf '*'
         fi
    done
else
  echo "Incorrect Login Credentials Format!" | tee -a $LOG_FILE
  exit 1
fi

# ******************************************************************
#  Check if database server name is entered else prompt to get it
# ******************************************************************
while [ "$HOST" = "" ]
do
    if [ "$HOST" = "" ];then
       echo "Enter database host name: "
       read HOST
    else
        echo "Enter database host name: "
        HOST=""
    fi
done

# ******************************************************************
#  Check if database port is entered else prompt to get it
# ******************************************************************
while [ "$PORT" = "" ]
do
    if [ "$PORT" = "" ];then
       echo  "Enter database port: "
       read PORT

    else
        echo  "Enter database port : "
        PORT=""
    fi
done

# ******************************************************************
#  Check if database SID is entered else prompt to get it
# ******************************************************************
while [ "$SID" = "" ]
do
    if [ "$SID" = "" ];then
        echo  "Enter database SID If SID Not available Enter-(NO): "
        read SID
    else
        echo  "Enter database SID1: "
        SID=""
    fi
done

# ******************************************************************
#  Check if database SERVICE NAME is entered else prompt to get it
# ******************************************************************
while [ "$SERVICE_NAME" = "" ]
do
    if [ "$SERVICE_NAME" = "" ];then
        echo  "Enter database SERVICE_NAME If SERVICE NAME Not available Enter-(NO): "
        read SERVICE_NAME
    else
        echo  "Enter database SERVICE_NAME1: "
        SERVICE_NAME=""
    fi
done
#################################################################
# Log
#################################################################
echo "App Login ID: $APPS_LOGIN" >> $LOG_FILE
echo "App Login Password: *******" >> $LOG_FILE
echo "Database Host Name: $HOST" >> $LOG_FILE
echo "Database Port : $PORT" >> $LOG_FILE
echo "Database SID:  $SID" >> $LOG_FILE
echo "Database SERVICE_NAME: $SERVICE_NAME" >>  $LOG_FILE
#################################################################

  if [ "$SID" = "NO" ];then
      CONNECT_STRING="(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SERVICE_NAME)))"
  else
      CONNECT_STRING="(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))"
  fi

echo "--------------------------------------------------------------------"         | tee -a $LOG_FILE
echo "            BEGIN INSTALLATION                                      "         | tee -a $LOG_FILE
echo "--------------------------------------------------------------------"         | tee -a $LOG_FILE



#####Changing the directory back to the present working directory
cd $CUR_DIR

chmod -R 777 $CUR_DIR/IMPORT/*


##########################################################
###### THIS IS USED TO INSERT THE XML INTO MDS ###########
##########################################################

cd $CUR_DIR/IMPORT
for dir in `find . -type d -name "*webui*"`
do
count=0
xmlfilecount=`find $dir -name *.xml | sed "s|^\.||" | wc -l`
  for line in `find $dir -name *.xml | sed "s|^\.||"`
        do
                echo "--------------------------------------------------------------------"                      | tee -a $LOG_FILE
                echo "Importing Region $line..."                                                                 | tee -a $LOG_FILE
                echo "--------------------------------------------------------------------"                      | tee -a $LOG_FILE
                adjava -mx128m -nojit oracle.jrad.tools.xml.importer.XMLImporter $CUR_DIR/IMPORT$line -rootdir $CUR_DIR/IMPORT -username  $APPS_LOGIN -password $APPS_PWD  -dbconnection $CONNECT_STRING;
                                if [ $? -eq 0 ];
                                then
                                  count=`expr $count + 1`
                                  echo " Successfully imported $line" | tee -a $LOG_FILE
                                else
                                  echo " Error importing $line"       | tee -a $LOG_FILE
                                  exit 1
                                fi
  done
echo "-------------------------------------------------------------------------------------------------------"   | tee -a $LOG_FILE
echo "Total XMl count under ($dir)                                                          : $xmlfilecount"     | tee -a $LOG_FILE
echo "Total successfully Created                                                            : $count"            | tee -a $LOG_FILE
echo "-------------------------------------------------------------------------------------------------------"   | tee -a $LOG_FILE
done


