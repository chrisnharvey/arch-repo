#!/bin/bash

export SHELL=/bin/bash

sudo pacman -Syy

for i in * ; do
    if [ -d "$i" ]; then
        if [ -a "scripts/$i" ]; then
            cd scripts
            ./$i
            cd ../
        fi

        cd $i
        makepkg -C -f -s -r --noconfirm --skippgpcheck
        mv *.pkg.* /tmp/packages
        cd ..
    fi
done
