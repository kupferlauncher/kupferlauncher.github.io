#!/bin/sh

# This doc generation script depends on two things:
# 1. Checked-out kupfer in a sibling directory
# 2. Installed kupfer in /usr for the translated help pages

set -x
set -e

KUPFER=../kupfer

rm -rf Documentation/
rm -rf help

git --git-dir="$KUPFER/.git" archive HEAD help Documentation \
	| tar xf - --exclude=wscript

({
cd Documentation
make
git add -u .
git add -A *.html
})
({
cd help
make html

# deduplicate js files
for file in $(find . -name "*.html") ; do
	sed -i -e 's|src="\([[:alpha:].]*\)\.js"|src="../C/\1.js"|g' $file
done

# remove others
rm [a-z][a-z]/*.js

cp ../helpredirect.html index.html
ln -s C en
git add -A .

})

