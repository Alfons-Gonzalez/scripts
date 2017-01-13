#!/bin/bash
#
# fd 1 : stdout
# fd 2 : stderr
# exemple 1
# echo "Redirect STDOUT to STDERR" 1>&2 
# que passa si fem: 
# ./this_script.sh; ./this_script.sh > file.out
# exemple 2 es pot enviar stderr al mateix stdout
# echo "Redirect STDERR to STDOUT" 2>&1
# es millor stderr to file
# comand 2> stderr.txt
# o si volem que vagin junts
# command &> stdout_stderr.txt
