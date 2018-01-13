# RassPi Server Settings
Torrent Server

## General system settings

```
sudo (ALL:ALL)
passwd
mkdir .ssh && chmod 700 .ssh
nano .ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
nano /etc/ssh/sshd_config
	PasswordAuthentication no
	PubkeyAuthentication yes
	ChallengeResponseAuthentication no
systemctl reload ssh
apt install ufw
ufw allow 4444
ufw allow 80
ufw enable
ufw status
dpkg-reconfigure tzdata
```

## Extarnal HDD connect settings

```
apt install ntfs-3g
mkdir /media/Depo
mount /dev/sda1 /media/Data
nano /etc/fstab && 
	/dev/sda1 /media/Depo ntfs defaults	0 0
```

## Apache2 server settings

```
apt install apache2
nano /etc/apache2/apache2.conf
	<Directory /media/Depo>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
	</Directory>
nano /etc/apache2/sites-available/000-default.conf
	DocumentRoot /media/Depo
```

## transmission-daemon

```
apt install transmission-daemon
service transmission-daemon stop
nano /var/lib/transmission-daemon/info/settings.json
	change location
	"rpc-password":
	"rpc-username":
	"rpc-whitelist":
	"umask": 2,
ufw allow 9091
usermod -a -G debian-transmission user
service transmission-daemon start
```
