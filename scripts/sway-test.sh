#!/bin/bash

cp ~/.config/sway/config ~/.config/sway/config.orig && \
rm ~/.config/sway/config && \
mv ~/.config/sway/config.orig ~/.config/sway/config && \
chmod +w ~/.config/sway/config
