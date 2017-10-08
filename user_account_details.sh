#!/bin/bash
#
# Linux User Account Details _ Muhammed Iqbal
#
#
UserAccounts=($(grep /bin/bash /etc/passwd | awk -F: '{ print $1}'))
Active_Accounts ()
 {
  printf "%s\n"; echo "Active Accounts (users with shell access)";
  echo "------------------------------------------------"
  for a in "${!UserAccounts[@]}";do
  echo "$a. ${UserAccounts[$a]}";done
 }
Account_status ()
 {
  printf "%s\n"
  echo "Account Status (Password locked accounts will only be able to access by root)"
  echo "------------------------------------------------------------------------------"
  for i in "${UserAccounts[@]}";
    do  passwd -S $i | awk '{ print $1 $8 $9 $10 $11 $12 $13 }';done
 }
Last_Login_Details ()
 {
  printf "%s\n"
  echo "Last Login Details"
  echo "-------------------"
  lastlog -b 0 | grep -v "Never logged in";
 }
Active_Accounts
Account_status
Last_Login_Details