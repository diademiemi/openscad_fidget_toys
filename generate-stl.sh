#!/bin/bash


# openscad executable is the first argument
# e.g. generate-stl.sh /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
# or generate-stl.sh /usr/bin/openscad
openscad_executable=$1

if [ -z "$openscad_executable" ]; then
    openscad_executable=openscad
fi

for file in */*.scad; do
    echo "Building $file to ${file%.scad}.stl"
    $openscad_executable --enable=fast-csg --enable=manifold --enable=lazy-union --enable=predictible-output -o "${file%.scad}.stl" "$file"
done
