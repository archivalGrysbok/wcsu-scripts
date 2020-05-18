source /home/arclight/.bash_profile

cd /home/arclight/scripts

file=arclight_fileChanges.txt

while read -r line
do
  cd /home/arclight/scripts

  head -n 1  "$file"  >> processed.txt 
  #copies first line to backup file

  sed -i -e "1d" $file 
  # deletes first line

  buff=${line#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff#?}
  buff=${buff//Created/}
  buff=${buff//Updated/}
  buff=${buff//Removed/}

  file2index=${buff}

  runthis=$(echo $file2index | sed -r s',^(\/.*\/(.*)\/.*)+,FILE=\1 REPOSITORY_ID=\2 bundle exec rake arclight:index,')

  echo "$runthis"

  cd /home/arclight/arclight/
  eval $runthis

done < $file

