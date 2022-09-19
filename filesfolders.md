# filesfolders.sh

## Overview

Helper functions to deal with directories

## Index

* [cds](#cds)
* [mkdircd](#mkdircd)
* [empty_files](#empty_files)
* [count_files](#count_files)
* [dirsize](#dirsize)
* [ds](#ds)
* [dubigf](#dubigf)
* [numLines](#numlines)
* [numpages](#numpages)
* [most_frequent](#most_frequent)
* [numWords](#numwords)
* [showfile](#showfile)
* [searchnreplace](#searchnreplace)
* [safeedit](#safeedit)
* [linesort](#linesort)
* [removeduplines](#removeduplines)
* [fixeol](#fixeol)
* [underscore](#underscore)
* [files_lc](#files_lc)
* [dir_lc](#dir_lc)
* [files_swap](#files_swap)
* [subdir_find](#subdir_find)
* [zero](#zero)

## navigation

functions for easier navigation

### cds

Change directory and list files

#### Arguments

* **$1** (string): directory name

### mkdircd

Makes directory then moves into it

#### Arguments

* **$1** (string): directory name

## size and statistics

get sizes and statistics for files and folders

### empty_files

Show empty files in the directed directory
copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (string): path to check

### count_files

Count files in current directory
copyright 2007 - 2010 Christopher Bratusek

### dirsize

Finds directory sizes and lists them for the current directory

_Function has no arguments._

### ds

#### Arguments

* **$1** (string): directory for size

### dubigf

Size of items in directory

_Function has no arguments._

## File Edit and File Info

Functions for editing files or getting file infos

### numLines

Echo the lines of a file preceded by line   number

#### Arguments

* **$1** (string): filename

### numpages

How many pages will my text files print on?

#### Arguments

* **$1** (string): filename

### most_frequent

Computes most frequent used words of text file

#### Arguments

* **$1** (string): filenamesage:   most_frequent "file.txt"

### numWords

counts words in selection and displays result in zenity window
dependencies xsel, wc, zenity

### showfile

Show the contents of a file, including additional useful info

### searchnreplace

Search and replace words/phrases from text file

#### Arguments

* **$1** (string): whatever oldtext
* **$2** (string): whatever newtext
* **$3** (file(s)): to act on

### safeedit

Make a backup before editing a file

#### Arguments

* **$1** (string): filename

### linesort

sort lines in a text file

#### Arguments

* **$1** (string): filename

### removeduplines

remove duplicate lines in a file (without resorting)

#### Arguments

* **$1** (string): filename

### fixeol

Edit files in place to ensure Unix line-endings

#### Arguments

* **$1** (string): filename

## File Properties manipulation

helper functions to rename files or manipulate properties

### underscore

Changes spaces to underscores in names

### files_lc

move filenames to lowercase

_Function has no arguments._

### dir_lc

lowercase all files in the current directory

_Function has no arguments._

### files_swap

Swap 2 filenames around (from Uzi's bashrc)

#### Arguments

* **$1** (string): first filename
* **$2** (string): second filename

### subdir_find

Count total number of subdirectories in current directory starting with specific name.

## Wipe and Secure Delete

securely wipe stuff from disk

### zero

overwrite a file with zeros

#### Arguments

* **$1** (string): filename

