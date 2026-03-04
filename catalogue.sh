dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
cp catalogue.service /etc/systemd/system/catalogue.service
cp catalogue.service /etc/yum.repos.d/mongo.repo
useradd roboshop
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app || exit
unzip /tmp/catalogue.zip
cd /app || exit
npm install
sudo dnf install mongodb-mongosh -y
mongosh --host mongobd-dev.devops173.com </app/db/master-data.js
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue