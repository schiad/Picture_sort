#!/bin/bash

path=$(pwd)

origine="no route to"
out="no route to"

while [ ! -d "$path/$origine" ]
do
	echo "path to pictures to sort ? from actual path"
	read origine
	dir_origine=($path/$origine)
done

while [ ! -d "$path/$out" ]
do
	echo "path to sort picture from actual path"
	read out
	dir_out=($path/$out)
done

echo Pictures are in $dir_origine path.
echo Picture will be sorted in $dir_out path.

mkdir tri

for i in $(ls *mp4 *jpg *arw *crw *cr2 *dng *kdc *mrw *nef *nrw *orf *ptx *pef *raf *x3f *raw *rw2 $dir_origine)
do
	name=""
	name=$(exiv2 -P nxyytv $dir_origine/$i | grep DateTime | sed 's/ \{1,\}/ /g' | cut -d' ' -f4 | sed 's/://g')
	if [ -z ${#name} ];
	then
		echo name from filename $name.
		name=$(echo $i | cut -d_ -f2)
	fi
	
	echo file : $i
	if [ -n ${#name} ];
	then
		mkdir $dir_out/$name 2>> ./logs.txt
		mv $dir_origine/$i $dir_out/$name 2>> ./logs.txt
	fi
done
