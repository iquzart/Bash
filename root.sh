if [ $UID == 0 ]; then
   echo " You are trying to login as root, do you really want to - Y/N :?"
   read ichoice
fi
if [ $ichoice == "Y" ]; then
   export PS1="\[\e[0;31m\]\u \[\e[0;37m\]\h[\w]\\$\[\e[0m\]"
   echo 'ALERT - Root Shell Access (`hostname`) on:' `date` `who` | mail -s "Alert: Root Access from `who | cut -d'(' -f2 | cut -d')' -f1`"  iquzart@mail.com
   
 else
   exit
fi
