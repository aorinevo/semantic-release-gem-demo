#!/bin/bash

mkdir -p ~/.gem
touch ~/.gem/credentials
chmod 600 ~/.gem/credentials
cat << EOF > ~/.gem/credentials
---
:rubygems_api_key: ${RUBYGEMS_API_TOKEN}
EOF

if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i "" -e "s/.*s.version.*/    s.version     = $(cat package.json | jq .version)/" semantic_release_gem_demo.gemspec
else
  sed -i semantic_release_gem_demo.gemspec -e "s/.*s.version.*/    s.version     = $(cat package.json | jq .version)/"
fi
gem build *.gemspec
gem push *.gem