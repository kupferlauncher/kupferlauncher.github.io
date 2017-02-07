#!/bin/sh

set -e

KUPFER=../kupfer

rm -rf Documentation/
rm -rf help
#cp -r ../kupfer/Documentation .
#cp -r ../kupfer/help .

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
cp ../helpredirect.html index.html
git add -A .
})

