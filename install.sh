#!/bin/bash
yum install httpd -y
cat <<EOF > /etc/yum.repos.d/MariaDB.repo
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.2/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1 > /etc/yum.repos.d/MariaDB.repo
EOF


yum -y install MariaDB-server MariaDB-client
 systemctl start mysql
/usr/bin/mysql_secure_installation
 systemctl start mysql
	
mysql -u root -p
CREATE DATABASE glpi;
CREATE USER 'glpi'@'%' IDENTIFIED BY 'senhadodbglpi';
GRANT ALL PRIVILEGES ON `glpi`.* TO 'glpi'@'%';
FLUSH PRIVILEGES;
exit;
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
sudo yum install php  php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-opcache php-apcu php-pear-CAS php-intl php-gd
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