#!/bin/bash

# Make sure we have npm installed
which npm > /dev/null
if [ ! ($? -eq 0) ]; then
    echo '>> NOTE: "npm" not found on $PATH';
    return;
fi;

packages=(
    nodemon
    flow-bin
    flow-coverage-report
)

npm install -g "${packages[@]}"
