Vagrant.configure("2") do |config|
    
    #define a do block for the web server 
    config.vm.define "web" do |web|
  
     #use the ubuntu/bionic64 VM template 
     web.vm.box = "ubuntu/bionic64"
 
     #setting up the networking such that the web server
     #a NAT network with a port forward to allow the outside world to connect to the server
     #also a private "host only" network to allow the web server to talk to the db server 
     web.vm.network "forwarded_port", guest: 80, host: 80
     web.vm.network "private_network", ip: "192.168.56.2"

    #installing apache, configuring php and mysql
     web.vm.provision "file", source: "phptest.php", destination: "phptest.php"

     web.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get install -y apache2
     apt-get install -y php libapache2-mod-php php-mysql
     systemctl restart apache2.service
     cp phptest.php /var/www/html
     echo "loading php web app"
     git clone https://github.com/axbjos/phpcrudecrudapp.git
     cd phpcrudecrudapp
     mv * /var/www/html
     SHELL

    end
  
    #define a block for the db server
    config.vm.define "db" do |db|
  
     db.vm.box = "ubuntu/bionic64"
  
     #connect the VM to the same private "host only" as the web server
     db.vm.network "private_network", ip: "192.168.56.2"

     #stage the mysql config file, the line below will copy the file from your laptop
     #to the VM and put it in the /home/vagrant director (aka Vagrant's home directory)
     db.vm.provision "file", source: "50-server.cnf", destination: "50-server.cnf"
     db.vm.provision "file", source: "addusers.sql", destination: "addusers.sql"

     #add your awesome bash commands to install as much of a mysql
     #database server as you can
     db.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt install -y mariadb-server
     git clone https://github.com/datacharmer/test_db.git
     cd  test_db
     mysql -t < employees.sql
     cd ..
     cp 50-server.cnf /etc/mysql/mariadb.conf.d/
     systemctl restart mariadb
     cd /home/vagrant
     echo "securing mysql and adding joeaxberg user"
     mysql -t < addusers.sql
     echo "done"
     SHELL
  
    end  

  end
