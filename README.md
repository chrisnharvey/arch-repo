# Arch Repo

I have built an Arch Linux repo for pacman that contains some ueful pre-built packages from
the AUR.

## Install this repo

Edit ```/etc/pacman.conf``` in your text editor of choice.

Add the following lines

```
[chrisnharvey]
SigLevel = Never
Server = https://arch-repo.chrisnharvey.com
```

## Package signing

At the moment, the packages are not signed. This will be addressed in the future.
