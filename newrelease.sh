#!/bin/sh

test -z "$2" && echo Usage example: $0 v302 v303 && exit 1

sed -i -e "s|\b$1\b|$2|g" index.html
