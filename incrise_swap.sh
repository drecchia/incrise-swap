#!/bin/bash
# Version - 1.0
INCRISER='/home/doing-newx/incrise_swap.sh'

[ $UID != '0' ] && { echo 'You must be root......';exit;}
if [ ! "$1" ];then
cat << EOF

Made by ALASKA - 31/08/02
Usage: incrise_swap.sh Mb
Like: incrise_swap.sh 5 ( and you will get more 5 Mb of swap )
      incrise_swap.sh -clean ( remove previous swap files )
      incrise_swap.sh -mon ( will mon your sys and incrise when needed )

EOF
exit
fi
if [ "$1" = '-mon' ];then
# monitorar ram depois swap livre
$INCRISER -clean
sleep 3 s
while [ ! "$swapack" ];do
sleep 15 s
fram=$(free -m|grep [0-9]|awk '{ print $4 }'|head -n1)
[ "$fram" -lt '8' ] && { $INCRISER 25;swapack='yes';}
done
while : ;do
sleep 15 s
fswap=$(free -m|grep [0-9]|tail -n1|awk '{ print $4 }')
[ "$fswap" -lt '5' ] && { $INCRISER 15;}
done
exit 
fi

[ "$1" = '-clean' ] && { for x in `ls /tmp/incrise_swap 2> /dev/null`;do swapoff /tmp/incrise_swap/$x 2> /dev/null;rm -f /tmp/incrise_swap/$x;done;rmdir /tmp/incrise_swap 2> /dev/null;exit;}

[ -e "/tmp/incrise_swap" ] || mkdir /tmp/incrise_swap
begin='0'
until [ ! -e "/tmp/incrise_swap/extra_swap.$begin" ];do
let begin=$begin+1;done
offile="/tmp/incrise_swap/extra_swap.$begin"
dd if=/dev/zero of=$offile count=${1}000 bs=1024 &> /dev/null
mkswap $offile 
swapon $offile 

