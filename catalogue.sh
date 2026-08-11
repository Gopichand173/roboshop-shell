# 1. Setup NodeJS
source common.sh
component=catalogue
NODEJS

dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.gdevops72.com </app/db/master-data.js
