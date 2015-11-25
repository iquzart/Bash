#!/bin/bash

# find all nodes on this intranet

# create report file with date
fd=$(date +%m%d%y%H%M%S)
echo -e "IP$fd\nReport of IP addresses on this intranet, test started at \n$(date)\n\nThe following IP addresses were found:" > IP$fd.txt
echo -e " Okay. Mind you, this could take a couple of minutes.\nI'll be scanning all 254 possibilities between 10.10.1.1 and 10.10.1.254\nI will ring the system bell when I am done.\nHere we go..."
for i in 10.10.10.{1..254}
do
echo "scanning ... ... ..."
if ping -c1 -w1 $i &>/dev/null
then
echo -e "AHA! Got one! ---- $i is up!"
echo -e $i >> IP$fd.txt
fi
done
echo -e "That's all I got.\Test completed at\n$(date)\n" >> IP$fd.txt
echo -e \\a
echo -e "Your report is IP$fd.txt, and this is what it says:\n"
cat IP$fd.txt
exit
