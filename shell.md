# shell

Terminal functions

## Overview

helper functions for the work in the terminal

## Index

* [text_separator](#text_separator)
* [need](#need)

### text_separator

Helper function to separate output with a given character

#### Arguments

* **$1** (string): (optional) character for separation, default is `-`
* **$2** (int): (optional) how much characters to print, default is 80

### need

Helper function to check if a given tool is installed, otherwise die

#### Arguments

* **$1** (string): name of the binary
* **$2** (string): additional text to the error message (e.g. where to download)

