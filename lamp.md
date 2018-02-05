```
sudo apt install apache2 mysql-server php libapache2-mod-php php-mcrypt php-mysql && mysql_secure_installation 
sudo nano /etc/apache2/mods-enabled/dir.conf //priority//
sudo nano /etc/apache2/apache2.conf // change location of server files //
sudo nano /etc/apache2/sites-available/000-default.conf // change location of server files 
```
```
sudo systemctl restart apache2
sudo systemctl status apache2
```