# 1. Setup NodeJS
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
useradd roboshop
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app || exit
unzip /tmp/catalogue.zip
cd /app || exit
npm install

dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.devops173.com </app/db/master-data.js
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue