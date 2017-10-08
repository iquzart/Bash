#!/bin/bash
#
#    Compile Oracle Apps Forms
# ------------------------------
#      v0.2      Meraas IT
#
read -a arr -p "Enter_Form_Name:"
echo "Enter Password for user 'apps':"
pswd=''
while IFS= read -r -s -n1 char; do
  [[ -z $char ]] && { printf '\n'; break; } # O/P \n and break.
  if [[ $char == $'\x7f' ]]; then # backspace
      # Erase last char from output variable.
      [[ -n $pswd ]] && pswd=${pswd%?}
      # Delete '*' to the left.
      printf '\b \b'
  else
    pswd+=$char
    printf '*'
  fi
done
for module in ${arr[@]};
do
  frmcmp_batch userid=apps/$pswd module=${module}.fmb output_file=$XXCUST_TOP/forms/US/${module}.fmx
done
