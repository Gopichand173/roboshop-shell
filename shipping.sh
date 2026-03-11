if [ -z $1 ]; then
  echo Input Password is missing
  exit 1
  fi

source common.sh
component=shipping
MAVEN
dnf install mysql -y

##sudo bash shipping.sh Roboshop@1
for file in schema app-user master-data; do
mysql -h mysql-dev.devops173.com -uroot -p$1 < /app/db/$file.sql
done
