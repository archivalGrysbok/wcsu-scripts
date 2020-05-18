source /home/arclight/.bash_profile

nohup /usr/local/bin/fswatch -r /home/arclight/arclight/data/ead/ -t -x --event Created --event Updated >> /home/arclight/scripts/arclight_fileChanges.txt &
