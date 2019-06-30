#!/bin/bash
for f in .??*
do
    [ "$f" = ".git" ] && continue
    filepath=$(cd $(dirname $0) && pwd)/"$f"
    ln -svf $filepath "$HOME"/"$f"
done

ln -svf $(cd $(dirname $0) && pwd)/nvim "$HOME"/.config/nvim
