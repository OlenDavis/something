#!/bin/bash

rm -rf node_modules bower_components

npm install

bower cache clean

bower install

grunt --force

grunt watch --force
