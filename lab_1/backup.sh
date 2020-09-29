#!/usr/bin/bash
for file in *
do
if [ ${file: -4} != ".bak" ]
then
if ! [ -f ${file%.*}.bak ]
then
cp $file ${file%.*}.bak
echo  "$file is copied as ${file%.*}.bak"
fi
fi
done

