#!/bin/bash

echo -e
echo -e "The script may require root user"
echo -e
echo -e "SSL installer for Ubuntu & Debian"
echo -e "What OS are you using?"
echo -e "1) Ubuntu"
echo "2) Debian "
read os

while [[ $os != @(1|2) ]]
do
	echo "Please insert a valid number."
	read os
done

echo "What's your domain? "
read domain

echo "Would you like to include www too? (y/n) "
read www

if [ $os -eq 1 ]; then
	# ubuntu
	sudo apt-get install -y software-properties-common
	add-apt-repository ppa:certbot/certbot
	sudo apt-get update -y
	sudo apt-get install python-certbot-apache -y
	if [ $www = "y" ]; then
		sudo certbot --apache -d $domain -d www.$domain
	else
		sudo certbot --apache -d $domain
	fi
	sudo certbot renew --dry-run
elif [ $os -eq 2  ]; then
	# debian
	echo "deb http://ftp.debian.org/debian buster-backports main" >> /etc/apt/sources.list
	apt update -y
	apt install python-certbot-apache -t buster-backports -y
	if [ $www = "y" ]; then
		certbot --apache -d $domain -d www.$domain
	else
		certbot --apache -d $domain
	fi
	certbot renew --dry-run
	
fi

echo " "
echo -e "All done!"
