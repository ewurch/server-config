# User setup
## Create user
read 'Username: ' username 
adduser $username
## Add user to sudo group
usermod -aG sudo $username