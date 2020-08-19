#!/bin/bash

export SHELL=/bin/bash

repo-add -s /tmp/packages/arched.db.tar.xz

cat stubs/local-repo | sudo tee -a /etc/pacman.conf

sudo pacman -Syyu --noconfirm

for i in packages/* ; do
    if [ -d "$i" ]; then
        cd ./$i

        for package in * ; do
            if [ -a "scripts/$package" ]; then
                cd scripts
                ./$package
                cd ../$i/$package
            fi

            cd $package
            makepkg -C -f -s -r --noconfirm --skippgpcheck
            mv *.pkg.* /tmp/packages
            cd ..

            repo-add -s /tmp/packages/arched.db.tar.xz /tmp/packages/*.pkg.tar.zst

            sudo pacman -Syy
        done

        cd ../..
    fi
done