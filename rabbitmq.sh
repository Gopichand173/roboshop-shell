# 1. Create the RabbitMQ Repo file
cat <<EOF > /etc/yum.repos.d/rabbitmq.repo
[modern-erlang]
name=modern-erlang-el9
baseurl=https://yum1.novemberain.com/erlang/el/9/\$basearch
        https://yum2.novemberain.com/erlang/el/9/\$basearch
        https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/rpm/el/9/\$basearch
enabled=1
gpgcheck=0

[rabbitmq-el9]
name=rabbitmq-el9
baseurl=https://yum2.novemberain.com/rabbitmq/el/9/\$basearch
        https://yum1.novemberain.com/rabbitmq/el/9/\$basearch
        https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/rpm/el/9/\$basearch
enabled=1
gpgcheck=0
EOF

# 2. Install RabbitMQ
dnf install rabbitmq-server -y

# 3. Start and Enable
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

# 4. Create User
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"