#!/bin/bash

home="$HOME/Schreibtisch/Code/newPC"
cp ${home}/.bashrc ~/.bashrc
${installers}/install.sh
for i in $( ls ${config}); do
  ./$i
done
