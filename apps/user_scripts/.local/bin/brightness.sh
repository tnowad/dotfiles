#!/bin/bash
brightnessctl g | awk -v max=$(brightnessctl m) '{printf "%.0f%%\n", ($1 / max) * 100}'
