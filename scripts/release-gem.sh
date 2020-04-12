#!/bin/bash

mkdir -p ~/.gem
touch ~/.gem/credentials
chmod 600 ~/.gem/credentials
echo ":rubygems_api_key: Bearer ${RUBYGEMS_API_KEY}" >> ~/.gem/credentials
sed -i "" "s/.*s.version.*/    s.version     = $(cat package.json | jq .version)/" semantic_release_gem_demo.gemspec
gem build *.gemspec
gem push --key rubygems_api_key *.gem