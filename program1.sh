#!/bin/bash
#This program is to archive the directory files which are changed.
snapshot=$(date +%d%h%y%H%m%s)test_dir
if  [ ! -d "temp_dir" ]  #checks for the directory exists or not?
then
	cp -R tes_dir temp_dir #if no  directory , then creates it and copies all source files to destination
fi

ch=$(diff <(find test_dir/ -type f -exec md5sum {} + | sort -k 2 | cut -f1 -d" ") <(find temp_dir/ -type f -exec md5sum {} + | sort -k 2 | cut -f1 -d" "))

echo $ch
if  [ -z "$ch" ] #checks for variable empty  
then
	echo " No changes in the contents of the files in test_dir!!!"
else
	tar -zcvf $snapshot.tar.gz test_dir
	echo "The Files of test_dir are archived in tar file, is created!"
fi

cp -RT test_dir temp_dir  #only files of test_dir are copied from source dir to destination dir not the dir(test_dir)

