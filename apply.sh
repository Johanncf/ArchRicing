#!/usr/bin/env bash
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "ArchRicing: BASH_SOURCE: $script_dir"

# 1. Configs
source Config/apply.sh
