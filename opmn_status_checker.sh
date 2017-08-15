#!/bin/bash
OPMN_Component=($(adopmnctl.sh status -l | grep -w "Down" | awk '{print $3}'))
if [[ $OPMN_Component ]]; then
      {
        printf "%s\n"
        printf "%s\n"
        printf "%s\n"
        printf "%s\n" "=================================================="
        printf "%s\n"  "Failed OPMN Component(s):"
        printf "%s\n" "--------------------------------------------------"
        printf "%s\n"   "${OPMN_Component[@]}"
        printf "%s\n" "=================================================="
        printf "%s\n"
        printf "%s\n"
        printf "%s\n"
        adopmnctl.sh status -l | awk 'NR>4 && NR<=19' 
      } | mailx -s "Critical: PROD Alert! $(hostname -s) - $(echo ${#OPMN_Component[@]}):OPMN Service Component(s) Down" \
        muhammed-ams@localhost
else
    echo "Error: Please check the script"
fi
