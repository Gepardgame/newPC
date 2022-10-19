#!/bin/bash

${installers}/install.sh
for i in $( ls ${home}/configs); do
  ./$i
done
cp ${home}/.bashrc ~/.bashrc
