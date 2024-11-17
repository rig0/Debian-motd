#! /bin/bash

# Install prerequisites
apt update && apt dist-upgrade -y
apt install lolcat linuxlogo toilet figlet cowsay fortune

# Backup up original motd
mv /etc/motd /etc/motd.bak

# Comment out original linux os and kernel info
sed -i -e 's/uname -snrvm/#uname -snrvm/g' /etc/update-motd.d/10-uname

# Create custom message
touch /etc/update-motd.d/99-custom-motd
echo "#!/bin/bash" >> /etc/update-motd.d/99-custom-motd
echo "{" >> /etc/update-motd.d/99-custom-motd
echo "  /usr/games/fortune | /usr/games/cowsay -f tux" >> /etc/update-motd.d/99-custom-motd
echo "  toilet -f ivrit \"$HOSTNAME\"" >> /etc/update-motd.d/99-custom-motd
echo "  linuxlogo -a -g -u -d -s -k -F \"Debian $(cat /etc/debian_version) Bookworm \n#O Kernel #V \n#M #T #R RAM \n#U\"" >> /etc/update-motd.d/99-custom-motd
echo "} | /usr/games/lolcat -p 13 --force" >> /etc/update-motd.d/99-custom-motd
chmod +x /etc/update-motd.d/99-custom-motd