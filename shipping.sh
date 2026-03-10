source common.sh
component=shipping
MAVEN
dnf install mysql -y
mysql -h mysql-dev.devops173.com -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h mysql-dev.devops173.com -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h mysql-dev.devops173.com -uroot -pRoboShop@1 < /app/db/master-data.sql
