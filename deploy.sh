#!/bin/bash

gitbook build
git add .
git commit -m 'deploy to gh-pages'
git subtree push --prefix _book origin gh-pages