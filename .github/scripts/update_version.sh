#!/usr/bin/env bash
set -euo pipefail

VERSION="$1"

echo "Updating Ruby gem version to $VERSION"

# Replace VERSION value inside version.rb
sed -i.bak "s/VERSION = \".*\"/VERSION = \"${VERSION}\"/" lib/ms/rb/version.rb

# Update Gemfile.lock if exists
bundle install

echo "VERSION updated to $VERSION"
