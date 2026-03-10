APP_PREREQ(){
  cp ${component}.service /etc/systemd/system/${component}.service || exit
    useradd roboshop
    rm -rf /app
    mkdir /app
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip
    cd /app || exit
    unzip /tmp/${component}.zip
    cd /app || exit
}
SYSTEMD(){
   systemctl daemon-reload
    systemctl enable ${component}
    systemctl start ${component}
}
NODEJS(){
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  dnf install nodejs -y
  APP_PREREQ
  npm install

 SYSTEMD
}

PYTHON(){
  dnf install python3 gcc python3-devel -y
  APP_PREREQ
  pip3 install -r requirements.txt

  SYSTEMD
}