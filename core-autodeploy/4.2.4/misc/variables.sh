#!/bin/bash
#######################################################
# Version: 02r                                        #
#######################################################

# Variables
INSTALLDIR="/home/zenoss/zenoss424-srpm_install"
export ZENHOME=/usr/local/zenoss
export PYTHONPATH=/usr/local/zenoss/lib/python
export PATH=/usr/local/zenoss/bin:$PATH
export INSTANCE_HOME=$ZENHOME

# Functions
menu-os () {
echo && echo "...Non Supported OS detected...would you like to continue anyways?"
PS3='(Press 1 or 2): '
options=("Yes" "No")
select opt in "${options[@]}"
do
case $opt in
"Yes")
echo "...continuing script with Non Supported OS...good luck!"
break
;;
"No")
echo "...stopping script" && exit 0
break
;;
        *) echo invalid option;;
esac
done } 
detect-os2 () {
if grep -Fxq "Ubuntu 13.04" /etc/issue.net
        then    echo "...Supported OS detected."
elif grep -Fxq "Ubuntu 13.10" /etc/issue.net
       then    echo "...Supported OS detected."
elif grep -Fxq "Ubuntu 12.04.3 LTS" /etc/issue.net
       then    echo "...Supported OS detected."
else    menu-os
fi      }
detect-os3 () { 
if grep -Fxq "Debian GNU/Linux 7" /etc/issue.net
        then    echo "...Supported OS detected."
elif grep -Fxq "Debian GNU/Linux 6.0" /etc/issue.net
        then    echo "...Supported OS detected (with a few bugs)" && echo && echo "Notes: There is an active bug that caused the install to fail" && echo && echo "See https://github.com/hydruid/zenoss/issues/8" && sleep 10 && menu-os
else    menu-os
fi      }
detect-arch () {
if uname -m | grep -Fxq "x86_64"
        then    echo "...Correct Arch detected."
        else    echo "...Incorrect Arch detected...stopped script" && exit 0
fi	}
detect-user () {
if [ `whoami` != 'zenoss' ];
        then    echo "...All system checks passed."
        else    echo "...This script should not be ran by the zenoss user" && exit 0
fi	}
mysql-conn_test () {
mysql -u root -e "show databases;" > /tmp/mysql.txt 2>> /tmp/mysql.txt
if grep -Fxq "Database" /tmp/mysql.txt
        then    echo "...MySQL connection test successful."
        else    echo "...Mysql connection failed...make sure the password is blank for the root MySQL user." && exit 0
fi	}
debian-testing-repo () {
cp /etc/apt/sources.list /etc/apt/sources.list.orig
wget -N https://raw.github.com/hydruid/zenoss/master/core-autodeploy/4.2.4/misc/debian-testing-repo.list -P /root/
mv /root/debian-testing-repo.list /etc/apt/sources.list
apt-get update
apt-get -t testing install libc6 libc6-dev -y
cp /etc/apt/sources.list.orig /etc/apt/sources.list
apt-get update
	}
give-props () {
apt-get install lynx -y
lynx http://hydruid-blog.com/?cat=5 &
lynx http://hydruid-blog.com/?cat=5 &
lynx http://hydruid-blog.com/?cat=5 &
wget -N http://softlayer-dal.dl.sourceforge.net/project/zenoss/zenoss-4.2/zenoss-4.2.4/4.2.4-1897/zenoss_core-4.2.4-1897.el6.src.rpm -P ~zenoss/
killall lynx 2>&1 /dev/null
apt-get remove lynx -y
        }
