#!/bin/sh
#
du -ks * | sort -nr | cut -f2 | xargs -d '\n' du -sh
