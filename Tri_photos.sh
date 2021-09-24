#!/bin/bash

mkdir tri

for i in $(ls *mp4 *jpg *dng)
do
	name=$(echo $i | cut -d_ -f2)
	echo $i
	mkdir ./tri/$name
	cp $i ./tri/$name #&& rm $i
done
