# Fedora 36 Kickstart Configuration

# Configure mirrors for sources
url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-36&arch=x86_64"

# Use text based anaconda installer instead of graphical
text

# Keyboard layouts
keyboard --vckeymap=gb --xlayouts='gb'

# System language
lang en_GB.UTF-8

# Network information
network  --bootproto=dhcp --device=enp1s0 --ipv6=auto --activate
network  --hostname=servervm

%packages
@^minimal-environment
%end

# Run the Setup Agent on first boot
firstboot --enable

# Disk configuration
ignoredisk --interactive
clearpart --all
part /boot --fstype="ext4" --ondisk=vda --size=1024
part swap --hibernation
part btrfs.01 --fstype="btrfs" --ondisk=vda --grow
btrfs none --label=fedora btrfs.01
btrfs / --subvol --name=/@ LABEL=fedora
btrfs /home --subvol --name=@home LABEL=fedora
btrfs /.snapshots/ --subvol --name=@.snapshots LABEL=fedora

# System timezone
timezone Europe/London --utc

# Root password and public ssh key
rootpw --iscrypted $6$akcR.mIADTmUNB92$WPy1DMqtfkNMSad61kiZAcyHHVwckIZ.MIDaRn6NJDk5JwSCeiM0msSJeLw1Ykc..6Bbx0iDLEU1yUmem3FRV/

sshkey --username=root "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuaIpt9o2JAbU6SM9ot5rZ+67rjk7osD3uCVAOfHH3woB5kvcVYT0VCG/ZMzHfVGaKu6t4TG4unZ/1UBo/JiHP9rmE+GNYlpbQYxZhIGZGWIxhbqDizNRk78i9xbxpaPIGSdXhIjOyTOKv/kQqOL8rZfMBTDdPoFyLITWtuhZVgK8LpIQrNzPLR9LacihDpZCv9VeRxBgfhkcCAAs2gc18ZH7B4MwN7F931r3HhS/kZ2QiF13hFpBfbdxIu0tQiDr+8nTsGvQR0N0ST0Ma+SQGRykNKSSGxUVWZhqCvJewsGNVU8C7P2ChhCN9xjJez+svz/7lWWJxh/KL3Z1p3BBzHi93MeZGLMWnbAmqKPq6K495XbS3DrQfM+Y6LMSAt+0nk0ZHjzTJTgSVIB3/AgwHL14gFPFvJxCLPdJHCXZH/irwdYMtp2VO4U/CvETcMHvQ3qg0e7z5eUF8446i+xf5+rjXB6PuZJ70Ewe/4X8Y2Eg2mk5Os/5iyiLJG4q4yT8= ashleigh@xps"
