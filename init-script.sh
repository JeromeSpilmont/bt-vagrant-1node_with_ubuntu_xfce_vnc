#!/bin/sh 
# installation et initialisation d'ubuntu server 
# pour avoir un gui et pouvoir utiliser vnc
########################################################

user="vagrant"
passwd="vagrant"

sudo apt update -y
sudo apt dist-upgrade -y
sudo apt install xfce4 xfce4-goodies -y
sudo apt install tightvncserver -y

#vncsercer
#vncserver -kill :1
#mkdir /home/$user/.vnc
echo $passwd | vncpasswd -f > /home/$user/.vnc/passwd
chown -R $user:$user /home/$user/.vnc
chmod 0600 /home/$user/.vnc/passwd

sudo chmod +x ~/.vnc/xstartup
sudo mv ~/vncserver@.service /etc/systemd/system/vncserver@.service

sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service
#vncserver -kill :1
sudo systemctl start vncserver@1