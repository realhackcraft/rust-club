#! /bin/sh

pandoc \
-t revealjs \
-s slides/$1.md \
-o output/$1.html \
--no-highlight \
--slide-level 2 \
--template templates/reveal-template.html \
--variable revealjs-url:https://unpkg.com/reveal.js@^5 \
--variable hlss:atom-one-dark
