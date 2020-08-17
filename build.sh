#!/bin/bash

export SHELL=/bin/bash

sudo pacman -Syyu --noconfirm
sudo cat stubs/local-repo >> /etc/pacman.conf

for i in packages/* ; do
    if [ -d "$i" ]; then
        cd ./$i

        for package in * ; do
            sudo pacman -Syy

            if [ -a "scripts/$package" ]; then
                cd scripts
                ./$package
                cd ../$i/$package
            fi

            cd $package
            makepkg -C -f -s -r --noconfirm --skippgpcheck
            mv *.pkg.* /tmp/packages
            cd ../..

            repo-add -s /tmp/packages/arched.db.tar.xz /tmp/packages/*.pkg.tar.{xz,zst} 2>&1
        done
    fi
done