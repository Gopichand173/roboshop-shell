# 1. Setup Erlang and RabbitMQ Repos
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

# 2. Install RabbitMQ
dnf install rabbitmq-server -y

# 3. Start and Enable the service
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

# 4. Create the User (Replace roboshop123 with your actual password)
# These are the lines 5 and 6 that failed earlier
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"