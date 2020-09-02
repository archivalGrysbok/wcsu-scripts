source /home/arclight/.bash_profile

/usr/local/bin/fswatch -r -L /var/www/html/arclight/data/ead/  --event Updated >> /home/arclight/scripts/arclight_fileChanges.txt 

#nohup /usr/local/bin/fswatch -r -L -0 /var/www/html/arclight/data/ead/ --event Created --event Updated | xargs -0 -n 1 -I {} echo {} >> /home/arclight/scripts/arclight_fileChanges.txt


