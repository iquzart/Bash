#!/bin/bash

echo "Installing Oracle EBS Pre-req packages"
echo '###################################################################'

declare -a rpm=( 'openmotif21-2.1.30-11.EL5.i386.rpm --nodeps'
xorg-x11-libs-compat-6.8.2-1.EL.33.0.1.i386.rpm
kernel-headers-2.6.18-308.el5.x86_64.rpm
binutils-2.17.50.0.6-20.el5.x86_64.rpm
libXrender-0.9.1-3.1.i386.rpm
kernel-headers-2.6.18-308.el5.x86_64.rpm
glibc-headers-2.5-81.x86_64.rpm
glibc-devel-2.5-81.x86_64.rpm
gcc-4.1.2-52.el5.x86_64.rpm
libstdc++-devel-4.1.2-52.el5.x86_64.rpm
gcc-c++-4.1.2-52.el5.x86_64.rpm
glibc-2.5-81.i686.rpm
glibc-2.5-81.x86_64.rpm
glibc-common-2.5-81.x86_64.rpm
glibc-devel-2.5-81.i386.rpm
glibc-devel-2.5-81.x86_64.rpm
libgcc-4.1.2-52.el5.i386.rpm
libgcc-4.1.2-52.el5.x86_64.rpm
libstdc++-devel-4.1.2-52.el5.i386.rpm
libstdc++-devel-4.1.2-52.el5.x86_64.rpm
libstdc++-4.1.2-52.el5.i386.rpm
libstdc++-4.1.2-52.el5.x86_64.rpm
libXi-1.0.1-4.el5_4.i386.rpm
libXp-1.0.0-8.1.el5.i386.rpm
libXp-1.0.0-8.1.el5.x86_64.rpm
libaio-0.3.106-5.i386.rpm
libaio-0.3.106-5.x86_64.rpm
libgomp-4.4.6-3.el5.1.x86_64.rpm
make-3.81-3.el5.x86_64.rpm
gdbm-1.8.0-26.2.1.el5_6.1.i386.rpm
gdbm-1.8.0-26.2.1.el5_6.1.x86_64.rpm
sysstat-7.0.2-11.el5.x86_64.rpm
util-linux-2.13-0.59.0.1.el5.x86_64.rpm
compat-libstdc++-296-2.96-138.i386.rpm
compat-libstdc++-33-3.2.3-61.i386.rpm
'elfutils-libelf-devel-0.137-3.el5.x86_64.rpm --nodeps'
elfutils-libelf-devel-static-0.137-3.el5.x86_64.rpm
libaio-devel-0.3.106-5.x86_64.rpm
unixODBC-libs-2.2.11-10.el5.i386.rpm
unixODBC-2.2.11-10.el5.i386.rpm 
'unixODBC-2.2.11-10.el5.x86_64.rpm --nodeps'
'unixODBC-devel-2.2.11-10.el5.x86_64.rpm --nodeps' );
  
  for i in "${rpm[@]}"
  do 
    echo rpm -ivh $i -y
    echo  $i Package installed Successfully!!
    echo '###################################################################'
  done
