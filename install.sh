#!/bin/bash
yum install httpd -y
echo "[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.2/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB"
 >> /etc/yum.repos.d/MariaDB.repo


yum -y install MariaDB-server MariaDB-client
 systemctl start mysql

mariadb-secure-installation
systemctl start mysql


mysql -uroot -p vubis@2022 -e "create database mbilling;"
mysql -uroot -p vubis@2022 -e "CREATE USER 'glpi'@'%' IDENTIFIED BY 'senhadodbglpi';"

mysql -uroot -p vubis@2022 -e "CREATE USER 'glpi'@'localhost' IDENTIFIED BY 'vubis@2022';"
mysql -uroot -p vubis@2022 -e "GRANT ALL PRIVILEGES ON \`glpi\` . * TO 'glpi'@'localhost' WITH GRANT OPTION;FLUSH PRIVILEGES;"    
mysql -uroot -p vubis@2022 -e "GRANT FILE ON * . * TO  'glpi'@'localhost' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"

firewall-cmd --permanent --add-service=mysql
firewall-cmd --reload
yum -y install httpd php 
systemctl enable httpd.service
systemctl start httpd.service
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent
firewall-cmd --reload
setsebool -P httpd_can_network_connect on
setsebool -P httpd_can_network_connect_db on
setsebool -P httpd_can_sendmail on
cd /var/www/html/
yum install wget -y
wget https://github.com/glpi-project/glpi/releases/download/10.0.0/glpi-10.0.0.tgz
tar -xvzf glpi*.tgz
chmod -R 777 /var/www/html/
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum -y install yum-utils
sudo yum-config-manager --enable remi-php74
sudo yum update
sudo yum install php php-cli
sudo yum install php  php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-opcache php-apcu php-pear-CAS php-intl php-gd -y
cat <<EOF > /etc/selinux/config
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
EOF
