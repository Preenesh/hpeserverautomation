#!/bin/bash

SAMedia=/media/opsware/windows/Gold/$1

# Get Current Permission of HPE SA Media Folder 
SAMediaPerm=$(stat -c "%a" $SAMedia)

# Set HPE SA Media Folder Permission to 777
if [ $SAMediaPerm -eq 755 ]
then
echo "Setting Folder $SAMedia Permission to 777"
chmod -R 777 $SAMedia
else
echo "Folder $SAMedia Permission is already set as 777"
fi

# Check and Create Archive Folder
if [ -d $SAMedia/Archive ]
then
echo "$SAMedia/Archive Folder already exists"
else
echo "$SAMedia/Archive Folder does Not exists"
echo "Creating Folder $SAMedia/Archive"
# Create Archive Folder
mkdir $SAMedia/Archive
fi

# Find WIM File in HPE SA Media Folder
WIMFile=$(find $SAMedia -maxdepth 1 -type f -name "*.wim")

# Get Filename of the WIMFile with out file extension
WIMFilename=$(basename $WIMFile .wim)

# Rename WIM File in HPE SA Media Folder
if [ -z $WIMFile ]
then
echo "No WIM Files found in Folder $SAMedia"
else
echo "Found $WIMFilename in Folder $SAMedia"
echo "Renaming $WIMFilename and moving it to Folder $SAMedia/Archive"
# Rename WIM File with Current Date and Move to Archive Folder
mv $WIMFile $SAMedia/Archive/${WIMFilename}_$(date "+%F").wim
fi

# Remove WIM Files older than 90 days from Archive Folder
find $SAMedia/Archive -maxdepth 1 -type f -name "*.wim" -mtime +90 -delete