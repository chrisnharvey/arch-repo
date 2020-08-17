#!/bin/bash

export SHELL=/bin/bash

sudo pacman -Syyu --noconfirm
cat stubs/local-repo | sudo tee -a /etc/pacman.conf

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
            cd ..

            repo-add -s /tmp/packages/arched.db.tar.xz /tmp/packages/*.pkg.tar.zst
        done

        cd ../..
    fi
done