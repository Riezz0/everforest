#!/bin/sh
sed -i \
         -e 's/#121c1c/rgb(0%,0%,0%)/g' \
         -e 's/#909b9b/rgb(100%,100%,100%)/g' \
    -e 's/#121c1c/rgb(50%,0%,0%)/g' \
     -e 's/#695453/rgb(0%,50%,0%)/g' \
     -e 's/#121c1c/rgb(50%,0%,50%)/g' \
     -e 's/#909b9b/rgb(0%,0%,50%)/g' \
	"$@"
