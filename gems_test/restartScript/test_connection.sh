#!/bin/bash

./requestUrl.sh 10.135.12.111:8001/gems/

echo -e `./requestUrl.sh 10.135.13.107:6001/gems/`
EXCODE=$?
#echo "$EXCODE"

echo -e `./requestUrl.sh 10.135.13.107:6002/gems/`
EXCODE=$?
#echo "$EXCODE"

echo -e `./requestUrl.sh 10.135.13.108:6001/gems/`
EXCODE=$?
#echo "$EXCODE"

echo -e `./requestUrl.sh 10.135.13.108:6002/gems/`
EXCODE=$?
#echo "$EXCODE"

echo -e `./requestUrl.sh 10.135.13.109:6001/gems/`
EXCODE=$?
#echo "$EXCODE"

echo -e `./requestUrl.sh 10.135.13.109:6002/gems/`
EXCODE=$?
#echo "$EXCODE"

echo -e `./requestUrl.sh 10.135.13.110:6001/gems/`
EXCODE=$?
#echo "$EXCODE"

echo -e `./requestUrl.sh 10.135.13.110:6002/gems/`
EXCODE=$?
#echo "$EXCODE"

exit
