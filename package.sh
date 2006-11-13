#!/bin/sh
package=$(awk '/^package/{print $3}' Makefile)
version=$(awk '/^version/{print $3}' Makefile)

dir=$package-$version
rm -rf $dir

svn up
mkdir -p $dir
cp -a nagios-notify templates $dir
tar --exclude=.svn --exclude='*~' -cjf $dir.tar.bz2 $dir

rm -rf $dir
