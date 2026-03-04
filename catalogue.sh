# 1. Setup NodeJS
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

# 2. Setup MongoDB Repo
# Instead of cp, we create the file exactly as the teacher showed
cat <<EOF > /etc/yum.repos.d/mongo.repo
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/4.4/x86_64/
gpgcheck=0
enabled=1
EOF

# 3. Create User and App Directory
useradd roboshop
mkdir /app

# 4. Download and Install App
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app || exit
unzip /tmp/catalogue.zip
npm install

# 5. Install MongoDB Shell and Load Schema
dnf install mongodb-mongosh -y
# Fixed the typo to mongodb-dev as per your Route53
mongosh --host mongobd-dev.devops173.com </app/db/master-data.js

# 6. Setup Systemd Service
# Instead of cp, we create the service file here
cat <<EOF > /etc/systemd/system/catalogue.service
[Unit]
Description = Catalogue Service

[Service]
User=roboshop
Environment=MONGO=true
Environment=MONGO_URL="mongodb://mongobd-dev.devops173.com:27017/catalogue"
ExecStart=/bin/node /app/server.js
SyslogIdentifier=catalogue

[Install]
WantedBy=multi-user.target
EOF

# 7. Start Service
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue