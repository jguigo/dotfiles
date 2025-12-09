#!/bin/bash

output_file="$HOME/media/screenshots/screenshot_$(date +'%Y-%m-%d-%H%M%S').png"
grimblast --freeze copysave area $output_file
