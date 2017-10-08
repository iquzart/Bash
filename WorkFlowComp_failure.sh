#!/bin/bash
#
#  Email alert on  Oracle EBS Workflow Mailer failure
# --------------------------------------------------
#  v0.1 -  Meraas IT
#
#
sqlr=$(sqlplus -S Username/Password< /tmp/query_1.sql  | awk '!/^$/')
if [[ "$sqlr" != "no rows selected" ]];
then
  echo -e  "SQL Query Result:\n\n\n  $sqlr" | mail -s "Critical: PROD Alert! Workflow Mailer Failed"  mailbox
fi
