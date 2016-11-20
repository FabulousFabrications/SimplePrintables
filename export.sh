cd src/
find . -iname '*.scad' -not -path "./lib/*" -exec sh -c 'mkdir -p "../stl/$(dirname "$1")"; openscad "$1" -o "../stl/$(dirname "$1")/$(basename "$1" .scad).stl"' _ {} \;