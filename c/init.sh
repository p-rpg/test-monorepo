#!/bin/sh

set -e

cd "$(dirname "$0")"

(echo '[' && find . -name "print_compile_commands.sh" -exec sh {} \; && echo ']') > ../compile_commands.json
