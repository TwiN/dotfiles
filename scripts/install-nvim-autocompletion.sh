#/bin/bash 
set -e

# This assumes that you have a working go dev environment

echo "Installing gocode for Deoplete Go completion"
go get -u github.com/stamblerre/gocode

