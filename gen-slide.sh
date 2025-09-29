#! /bin/sh

# --slide-level 2 \
pandoc \
-t revealjs \
-s slides/"$1.md" \
-o output/"$1.html" \
--no-highlight \
--template templates/reveal-template.html \
--variable revealjs-url:https://unpkg.com/reveal.js@^5 \
--variable hlss:atom-one-dark \

if [ "$2" = "-o" ]; then
    open output/"$1.html"
fi
