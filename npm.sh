#!/bin/bash

# Make sure we have npm installed
which npm > /dev/null
if [ ! ($? -eq 0) ]; then
    echo '>> NOTE: "npm" not found on $PATH';
    exit 1;
fi;

packages=(
    nodemon
    flow-bin
    flow-coverage-report
    leasot # todo list scraper
    vsce # VS Code extension cli
    yo # Yeoman
)

npm install -g "${packages[@]}"
