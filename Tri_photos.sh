#!/bin/bash

path=$(pwd)

origine="no route to"
out="no route to"

IFS=$'\n'

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

for i in $(ls $dir_origine/*)
do
	name=""
	name=$(exiv2 -P nxyytv $i | grep "DateTime " | sed 's/ \{1,\}/ /g' | cut -d' ' -f4 | sed 's/://g' | uniq)
	echo exif1 : $name
	if [ ${#name} -eq 0 ];
	then
		name=$(exiv2 -P nxyytv $i | grep "DateTimeDigitized " | sed 's/ \{1,\}/ /g' | cut -d' ' -f4 | sed 's/://g' | uniq)
		echo exif2 : $name
	fi
	
	if [ ${#name} -eq 0 ];
	then
		echo name from filename $i.
		name=$(basename $i | cut -d_ -f2)
		echo "name = $name"
	fi
	
	if [ -n ${#name} ];
	then
		echo "mkdir $dir_out/$name 2>> /dev/zero"
		mkdir $dir_out/$name 2>> /dev/zero
		echo "mv $i $dir_out/$name 2>> /dev/zero"
		mv $i $dir_out/$name 2>> /dev/zero
	fi
done
