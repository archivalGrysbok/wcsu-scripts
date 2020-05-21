source /home/arclight/.bash_profile

nohup /usr/local/bin/fswatch -r /var/www/html/arclight/data/ead/ -t -x --event Created --event Updated >> /home/arclight/scripts/arclight_fileChanges.txt &
