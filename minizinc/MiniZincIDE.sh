#!/bin/sh
cd /usr/local/MiniZincIDE-0.9.6-linux-x86_64 ### inclui esta linha apos criar links simbolicos em /usr/bin/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/lib
export QT_PLUGIN_PATH=$PWD/plugins
exec ./MiniZincIDE $@
