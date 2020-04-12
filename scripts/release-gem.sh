#!/bin/bash

mkdir -p ~/.gem
touch ~/.gem/credentials
chmod 600 ~/.gem/credentials
echo ":rubygems_api_key: Bearer ${RUBYGEMS_API_KEY}" >> ~/.gem/credentials
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i "" -e "s/.*s.version.*/    s.version     = $(cat package.json | jq .version)/" semantic_release_gem_demo.gemspec
else
  sed -i -e "s/.*s.version.*/    s.version     = $(cat package.json | jq .version)/" semantic_release_gem_demo.gemspec
fi
sed -i "" "s/.*s.version.*/    s.version     = $(cat package.json | jq .version)/" semantic_release_gem_demo.gemspec
gem build *.gemspec
gem push --key rubygems_api_key *.gem