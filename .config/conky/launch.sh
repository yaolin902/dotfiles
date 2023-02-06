#!/usr/bin/env bash

killall conky

conky -c ~/.config/conky/expandrc &
conky -c ~/.config/conky/conkyrc &
