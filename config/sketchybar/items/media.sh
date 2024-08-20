#!/bin/bash

sketchybar --add item media e \
           --set media label.color=$WHITE \
                    position=center \
                       label.max_chars=30 \
                       icon.padding_left=0 \
                       scroll_texts=off \
                       icon=􀑪             \
                       icon.color=$WHITE   \
                       background.drawing=off \
                       script="$PLUGIN_DIR/media.sh" \
           --subscribe media media_change
