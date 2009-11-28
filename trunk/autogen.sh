#!/bin/bash

autoconf --version &> /dev/null || {
  echo
  echo "**Error**: You must have \`autoconf' installed to compile this package."
  exit 1
}

libtoolize --version &> /dev/null || glibtoolize --version &> /dev/null || {
  echo
  echo "**Error**: You must have \`libtool' installed to compile this package."
  exit 1
}

automake --version &> /dev/null || {
  echo
  echo "**Error**: You must have \`automake' installed to compile this package."
  exit 1
}

aclocal --version &> /dev/null || {
  echo
  echo "**Error**: You must have \`aclocal' installed to compile this package."
  exit 1
}

echo "aclocal..."
aclocal $ACLOCAL_PARAMS &> /dev/null || exit 1

echo "autoheader..."
autoheader &> /dev/null || exit 1

echo "libtoolize..."
libtoolize --force &> /dev/null || glibtoolize --force &> /dev/null exit 1

touch NEWS ChangeLog

echo "automake..."
automake --add-missing &> /dev/null || exit 1

echo "autoconf..."
autoconf &> /dev/null || exit 1

rm -rf autom4te.cache

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/local/lib/pkgconfig

export PKG_CONFIG_PATH
./configure --prefix=/tmp
