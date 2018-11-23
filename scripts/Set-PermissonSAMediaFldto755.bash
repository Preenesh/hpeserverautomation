#!/bin/bash

SAMedia=/media/opsware/windows/Gold/$1
SAMediaPerm=$(stat -c "%a" $SAMedia)

if [ $SAMediaPerm -eq 777 ]
then
echo "Setting Folder $SAMedia Permission to 755"
chmod -R 755 $SAMedia
else
echo "Folder $SAMedia Permission is already set as 755"
fi