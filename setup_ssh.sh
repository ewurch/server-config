# SSH setup
## Copy ssh keys
mkdir $HOME/.ssh
## Prompt for ssh key
echo "Paste your ssh key here:"
read ssh_key
echo $ssh_key > $HOME/.ssh/authorized_keys

echo "SSH setup complete"
echo "Add The following to your ssh config:"
echo "PasswordAuthentication no\nChallengeResponseAuthentication no\nUsePAM no\nPermitRootLogin no\n"
echo "Restart the ssh service with:\n sudo systemctl restart ssh"

# Change name of the host -> <user>@<hostname>
echo "Enter the new hostname:" 
read hostname
sudo hostnamectl set-hostname $hostname

# Generate SSH keys for the user
ssh-keygen