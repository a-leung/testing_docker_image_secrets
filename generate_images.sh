#!/usr/bin/env bash

secret_file=super_secret_file
content=SUPER_SECRET_FILE_CONTENTS

echo $content > $secret_file

docker build -f dockerfile_no_write                -t image_no_write                               .
docker build -f dockerfile_with_write              -t image_with_write                             .
docker build -f dockerfile_with_write_and_delete   -t image_with_write_and_delete                  .
docker build -f dockerfile_with_write_and_delete   -t image_with_write_delete_and_squash --squash  .
 
mkdir images
 
docker save -o images/image_no_write                      image_no_write
docker save -o images/image_with_write                    image_with_write
docker save -o images/image_with_write_and_delete         image_with_write_and_delete
docker save -o images/image_with_write_delete_and_squash  image_with_write_delete_and_squash

echo "====== searching through images ======"
ag --search-binary $content images
