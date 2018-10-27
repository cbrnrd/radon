#!/bin/bash

cd ..

CURRENT_VERSION=$(cat lib/core/constants.rb | grep VERSION | cut -d '"' -f 2)


gem build radon.gemspec
gem install radon-$CURRENT_VERSION.gem