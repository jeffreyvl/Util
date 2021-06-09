ssh bash commands

check your keys
$ ls -al ~/.ssh

generate new key
$ ssh-keygen -t ed25519 -C "your_email@example.com"
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

start the ssh-agent in the background
$ eval `ssh-agent -s`

add key to ssh-agent
$ ssh-add ~/.ssh/id_ed25519

list keys from ssh-agent
$ ssh-add -l

delete keys from ssh-agent
$ ssh-add -D

