#!/bin/bash
read -p "Enter the date of logs[yyyymmdd]:" date
echo "Begin copy the logs start from date:$date"
sh multi_scp_download.sh scp.conf /home/weblogic/Oracle/Middleware/user_projects/domains/base_domain/gems/logs/S*_$date*.log /home/Projects/oms/gems_test/logs
echo "The logs has been download to /logs"
