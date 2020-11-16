source /home/arclight/.bash_profile

cd /home/arclight/scripts

file=/home/arclight/scripts/arclight_fileChangesSorted.txt

echo "sorting file changes"
sort -u /home/arclight/scripts/arclight_fileChanges.txt >> /home/arclight/scripts/arclight_fileChangesSorted.txt

rm /home/arclight/scripts/arclight_fileChanges.txt

echo "killing fswatch"
killall fswatch

echo "starting fswatch"
/usr/local/bin/fswatch -r -L /var/www/html/arclight/data/ead/  --event Created  --event Updated >> /home/arclight/scripts/arclight_fileChanges.txt &

echo "starting indexing loop"
while read -r line
do
  cd /home/arclight/arclight/

  head -n 1  "$file"  >> /home/arclight/scripts/processed.txt   #copies first line to backup file

  runthis=$(echo $line | sed -r s',^(\/.*\/(.*)\/.*)+,FILE=\1 REPOSITORY_ID=\2 bundle exec rake arclight:index,')

  runthis=$(echo $runthis | sed -r s'|REPOSITORY_ID=findingaids|REPOSITORY_ID=ctdbn|')

  echo "$runthis"

  cd /home/arclight/arclight/

  eval $runthis

  echo "going back to scripts directory"
  cd /home/arclight/scripts

  sed -i -e "1d" $file   # deletes first line

  cd /home/arclight/arclight/

  line=

  runthis=

done < /home/arclight/scripts/arclight_fileChangesSorted.txt

echo "all done :)"
