#!/bin/bash

function credits() {
clear
echo "Dit Script is gemaakt door Anouk, met wat hulp van deze persoon (simpel geëncrypt): z9AQCsteq4scsbDyo68D9YOF07ouSjFPwRIc+tI2EsY="
echo "Druk maar weer op ENTER ;)"
read ENTER
clear
menu

}

function menu() {
echo "Welkom bij het installatie script van Anouk Langenberg" 
echo " "
PS3='Maak uw keuze: '
options=("Installeer Webserver" "Installeer Nextcloud" "Beveiligingen" "Configuraties" "Sluit Script Af")
select opt in "${options[@]}"
do
    case $opt in
        "Installeer Webserver")
		clear
		echo "U installeert een Webserver welke moet het worden? (Apache/Nginx)"
        read answer0
            if [ "$answer0" == "Apache" ] ;then
                
                sudo apt install apache2 libapache2-mod-php7.4 openssl php-imagick php7.4-common php7.4-curl php7.4-gd php7.4-imap php7.4-intl pmbstring php7.4-mysql php7.4-pgsql php-ssh2 php7.4- sqlite3 php7.4-xml php7.4-zip
                sudo apt install mariadb-server
                sudo mysql_secure_installation
                
                sudo apt install apache2
                sudo apt install php
                    clear
                        echo "De Webserver Apache is geïnstalleerd. (Druk op ENTER om door te gaan...)"
                        read ENTER
                        clear
                        menu
        
            else if [ "$answer0" == "Nginx" ] ;then
                clear
                        sudo apt install imagemagick php-imagick php7.4-common php7.4-mysql php7.4-fpm php7.4-gd php7.4-json php7.4-curl  php7.4-zip php7.4-xml php7.4-mbstring php7.4-bz2 php7.4-intl php7.4-bcmath php7.4-gmp
                        sudo apt install mariadb-server
                        sudo mysql_secure_installation
                        sudo apt install nginx -y
                        sudo apt install mariadb-server
                        sudo mysql_secure_installation
                        sudo systemctl start nginx
                        sudo systemctl enable nginx
                        echo " "
                        echo "Nginx is succesfully installed. (Press ENTER to continue...)"
                            read ENTER
                            clear
                            menu
        
            else
                clear
                echo "Je hebt iets verkeerd ingevoerd: $answer0. (Druk op ENTER om door te gaan...)"
                read ENTER
                clear
                menu
            fi
            fi

            ;;
            
        "Installeer Nextcloud")
            clear
            echo "Voor welke webserver installeert u Nextcloud? (Apache/Nginx)"
            read answer1
            if [ "$answer1" == "Apache" ] ;then
            clear
            echo "Download gestart..."
                sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
                echo ' '
                echo 'Download voltooid (Druk op ENTER om hem uit te pakken)'
                read ENTER
                clear
                sudo unzip nextcloud-21.0.2.zip -d /var/www/nextcloud/
                echo " "
                echo "Nextcloud is uitgepakt (Druk op ENTER om door te gaan...)"
                read ENTER
                menu
                
            else if [ "$answer1" == "Nginx" ] ;then
                clear
                echo "Download gestart..."
                    sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
                    echo ' '
                    echo 'Download voltooid (Druk op ENTER om hem uit te pakken)'
                    read ENTER
                    clear
                    sudo unzip nextcloud-21.0.0.zip -d /usr/share/nginx/
                    echo " "
                    echo "Nextcloud is uitgepakt (Druk op ENTER om door te gaan...)"
                    read ENTER
                    menu   
            else
                        clear
                        echo "Er ging iets mis! (Druk op ENTER om door te gaan...)"
                        read ENTER
                        clear
                        menu
                
            fi
            fi            
             
            ;;
        "Beveiligingen")
            clear
            echo "Maak opnieuw uw keuze: "
            echo " -------------------------"
            echo "| 1) Installeer Fail2ban  |"
            echo "| 2) Maak een Certificaat |"
            echo "| 3) Installeer SSL       |"
            echo "| 4) Terug naar het menu  |"
            echo " -------------------------"
            read answer3
            
            if [ "$answer3" == "1" ] ;then
                clear
                    echo "Installeer Fail2ban"
                    sudo apt-get install fail2ban
                    sudo cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
                    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
                    sudo systemctl enable fail2ban
                    sudo systemctl start fail2ban
                    sudo systemctl status fail2ban.service
                    echo ' '
                    echo "Fail2ban is geïnstalleerd. (Druk op ENTER om door te gaan...)"
                    read ENTER
                    clear
                    menu
                    
            else if [ "$answer3" == "2" ] ;then
                clear
                    echo "Certificaat wordt aangemaakt..."
                                sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.key -out /etc/ssl/certs/apache-       selfsigned.crt
                                sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
                    clear
                    echo "Certificaat is succesvol aangemaakt (Druk op ENTER om door te gaan...)"
                    read ENTER
                    clear
                    menu
                    
            else if [ "$answer3" == "3" ] ;then
                clear
                        sudo apt-get install openssl
                        echo " "
                        echo "Openssl is installed. (Klik op ENTER om door te gaan...)"
                        read ENTER
                        clear
                        menu
            else if [ "$answer3" == "4" ] ;then
            clear
            menu
            
            
            else
			clear
            echo "Oeps, druk je nou alweer op een verkeerde knop? Druk nu maar op ENTER!"
            read ENTER
            clear
            menu
            
            fi
            fi
            fi
            fi
            ;;
            
        "Configuraties")
            clear
                echo "Wat wilt u configureren? maak uw keuze:"
                echo " --------------------------"
                echo "| 1) Apache Configureren   |"
                echo "| 2) Firewall Configureren |"
                echo "| 3) PHP Configuratie      |"
                echo "| 4) MYSQL Configuratie    |"
                echo "| 5) Terug naar hoofdmenu  |"
                echo "---------------------------"
                read answer4
            if [ "$answer4" == "1" ] ;then
                    sudo systemctl stop apache2.service
				    sudo nano /var/www/nextcloud/config/config.php
				    sudo systemctl restart apache2.service
                    clear
                        echo "Configuratie van Apache is voltooid. (Druk op ENTER om door te gaan...)"
                        read ENTER
                        clear
                        menu
                
            else if [ "$answer4" == "2" ] ;then
                clear
                    sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
                    sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
                    clear
                        echo "Uitzonderingen zijn aan de Firewall toegevoegd. (Druk op ENTER om door te gaan...)"
                        read ENTER
                        clear
                        menu
                        
            else if [ "$answer4" == "3" ] ;then
                clear
                    sudo nano /etc/php/7.4/cli/php.ini
                    clear
                        echo "Configuratie van PHP geslaagd. (Druk op ENTER om door te gaan...)"
                        read ENTER
                        clear
                        menu
                        
            else if [ "$answer4" == "4" ] ;then
            clear
            echo "Als u klaar bent met de configuratie van MYSQL dient u het commando 'EXIT' uit te voeren."
                sudo mysql -u root -p
                echo "Configuratie geslaagd. (Druk op ENTER om door te gaan...)"
                read ENTER
                clear
                menu
            
            else if [ "$answer4" == "5" ] ;then
                clear
                menu
            
            else
            clear
            echo "Je blijft wel bezig zeg, voer nou toch eens het juiste in! Druk maar weer op ENTER >:P"
            read ENTER
            clear
            menu
            
            fi
            fi
            fi
            fi
            fi
            
            ;;
        "Sluit Script Af")
            clear
            break
            ;;
            
        *) clear
        echo "Je hebt iets verkeerd ingevoerd: $REPLY (Druk op ENTER om door te gaan...)"
        read ENTER
        if [ "$ENTER" == "info" ] ;then
        credits
        else
        clear
        menu
        fi
        
        ;;
    esac
done

}

clear
menu
