#!/usr/bin/env bash
set -euo pipefail

VERSION="$1"

echo "Building gem version $VERSION..."

gem build ms-rb.gemspec

GEM_FILE="ms-rb-${VERSION}.gem"

echo "Pushing ${GEM_FILE} to RubyGems..."
gem push "${GEM_FILE}"
