# find.sh

## Overview

Functions and aliases to find files

## Index

* [find_execute](#find_execute)
* [find_current](#find_current)
* [find_endswith](#find_endswith)
* [find_startwith](#find_startwith)
* [find_larger](#find_larger)
* [find_pattern](#find_pattern)
* [find_and](#find_and)
* [grepfind](#grepfind)
* [fstr](#fstr)
* [grip](#grip)
* [newest](#newest)

### find_execute

find files with pattern $1 in name and Execute $2 on it

#### Arguments

* **$1** (string): search pattern
* **$2** (string): command to execute on found files

### find_current

find files under current directory

#### Arguments

* **$1** (string): search pattern

### find_endswith

find files whose name ends with a given string

#### Arguments

* **$1** (string): search pattern

### find_startwith

find files whose name starts with a given string

#### Arguments

* **$1** (string): search pattern

### find_larger

find files larger than a certain size (in bytes)

#### Arguments

* **$1** (string): search pattern

### find_pattern

find a file with a pattern in name in the local directory

#### Arguments

* **$1** (string): search pattern

### find_and

Find in file and ( AND relation ) 
Will search PWD for text files that contain $1 AND $2 AND $3 etc...
Actually it does the same as grep word1|grep word2|grep word3 etc, but in a more elegant way.

#### Arguments

* **$1** (string): search pattern1
* **$2** (string): search pattern2
* **$3** (string): search pattern3 (optional)

### grepfind

tgrep through files found by find, e.g. grepf pattern '*.c'
note that 'grep -r pattern dir_name' is an alternative if want all files

#### Arguments

* **$1** (string): search pattern for find
* **$2** (string): search pattern for grep

### fstr

find pattern in a set of files and highlight them

#### Arguments

* **$1** (string): search pattern for grep
* **$2** (string): search pattern for find

### grip

searches through the text of all the files in your current directory, see http://seanp2k.com/?p=13

#### Arguments

* **$1** (string): search pattern for grep

### newest

who is the newest file in a directory

#### Arguments

* **$1** (string): folder to search in (defaults to .)

