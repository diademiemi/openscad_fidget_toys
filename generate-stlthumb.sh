#!/bin/bash
colours=(3a849f f1a6b5 aaaaaa f1a6b5)

index=0

for file in */*.stl; do

    basename $file
    # Altnernate through the colours
    colour=${colours[$index]}

    echo "Creating thumbnail for $file to img/${file%.stl}.png with colour $colour"
    stl-thumb -m $colour 303030 303030 "$file" img/"$(basename ${file%.stl}).png"
    sleep 0.1

    if [ $index -eq 3 ]; then
        index=0
    else
        index=$((index+1))
    fi


done
