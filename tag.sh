#!/bin/sh
url=$(svn info | awk '/^URL:/{gsub("/trunk$", "", $2); print $2}')
rev=$(svn info | awk '/^Revision:/{print $2}')
version=$(awk -F= '/^version/{print $2}' Makefile | xargs)
tag="$version"

echo "making tag: $tag at revision $rev"
echo "press enter to continue"
read a
svn cp $url/trunk $url/tags/$tag
