#!/bin/bash

rm -rf ./packages
rm -rf /tmp/packages
mkdir /tmp/packages

for i in * ; do
    if [ -d "$i" ]; then
        if [ -a "scripts/$i" ]; then
            cd scripts
            ./$i
            cd ../
        fi

        cd $i
        makepkg -C -f -s -r --noconfirm
        mv *.pkg.* /tmp/packages
        cd ..
    fi
done
