#sudo apt update

execute "apt-get update" do
  command "apt-get update"
end


#sudo apt install -y apache2

#sudo service apache2 start



#sudo apt install -y mysql-server mysql-client
#sudo apt install -y php libapache2-mod-php php-mcrypt php-mysql

for pkg in [ "unzip","apache2", "mysql-server", "mysql-client", "php", "libapache2-mod-php", "php-mcrypt", "php-mysql"] do
  package "#{pkg}" do
    action :install
  end
end

service "apache2" do
action :start
end

   

#mysqladmin -u root password rootpassword

#execute "sqladmin" do
 # command "mysqladmin -u root password root"
#end


#wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands

remote_file "mysqlcommands" do
    source 'https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands'
    path "/tmp/mysqlcommands"
end


#sudo cp mysqlcommands /tmp/mysqlcommands


#mysql -uroot -prootpassword < /tmp/mysqlcommands
#mysql_session('root','rootpassword','localhost')

execute "mysql" do
  command "mysql -uroot -proot < /tmp/mysqlcommands"
end

#wget https://wordpress.org/latest.zip
#cp latest.zip /tmp/latest.zip

remote_file "latest.zip" do
    source 'https://wordpress.org/latest.zip'
    path "/tmp/latest.zip"
end

#sudo apt install -y unzip
 #package unzip do
 #   action :install
 # end
  


#sudo unzip /tmp/latest.zip -d /var/www/html

#archive_file 'name' do
#  destination  :"/var/www/html"
#  mode         :"'755'"
 # owner        :"/var/www/html/wordpress"
#  path         :"/tmp/latest.zip"
#end

execute "unzip" do
  command "unzip /tmp/latest.zip -d /var/www/html"
end


#wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php
remote_file "wp-config-sample.php" do
    source 'https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php'
    path "/var/www/html/wordpress/wp-config.php"
end


#sudo cp wp-config-sample.php /var/www/html/wordpress/wp-config.php

#sudo chmod -R 775 /var/www/html/wordpress
#sudo chown -R www-data:www-data /var/www/html/wordpress
#sudo service apache2 restart

execute "apache-restart" do
  command "systemctl restart apache2"
end



