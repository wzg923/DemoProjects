#!/bin/bash

#read -p "please input the choice:[Y/N]?" answer
#case $answer in
# y|Y)echo "yes!continue.";;
# n|N)echo "no!bye.";exit ;;
# *)echo "bad choice";exit 1;;
#esac

a="10.135.13.107"
#awk给变量赋值
s1=`echo $a | awk -F. '{print $4}'`
echo "s1:"$s1
#awk给变量赋值
echo $a | awk -F. '{print $1,$2,$3,$4}' | while read v1 v2 v3 v4
do
 echo v1=$v1 v2=$v2 v3=$v3 v4=$v4
done


exit
