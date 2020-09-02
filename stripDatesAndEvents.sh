source /home/arclight/.bash_profile

cd /home/arclight/scripts

file=arclight_fileChangesSorted.txt

sort -u /home/arclight/scripts/arclight_fileChanges.txt >> /home/arclight/scripts/arclight_fileChangesSorted.txt

rm /home/arclight/scripts/arclight_fileChanges.txt

killall fswatch

/usr/local/bin/fswatch -r -L /var/www/html/arclight/data/ead/  --event Created  --event Updated >> /home/arclight/scripts/arclight_fileChanges.txt

while read -r line
do
  cd /home/arclight/scripts

  head -n 1  "$file"  >> processed.txt   #copies first line to backup file

  sed -i -e "1d" $file   # deletes first line

  runthis=$(echo $line | sed -r s',^(\/.*\/(.*)\/.*)+,FILE=\1 REPOSITORY_ID=\2 bundle exec rake arclight:index,')

  runthis=$(echo $runthis | sed -r s'|REPOSITORY_ID=findingaids|REPOSITORY_ID=ctdbn|')

  echo "$runthis"

  cd /home/arclight/arclight/

  eval $runthis

  line=

  runthis=

done < /home/arclight/scripts/arclight_fileChangesSorted.txt
