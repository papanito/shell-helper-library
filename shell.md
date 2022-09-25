# shell.sh

## Overview

helper functions for the work in the terminal

## Index

* [need](#need)
* [apath](#apath)
* [terminal_title](#terminal_title)
* [xtitle](#xtitle)
* [open](#open)
* [daemon](#daemon)
* [die](#die)
* [editcmd](#editcmd)
* [repeatcmd](#repeatcmd)
* [align_center](#align_center)
* [align_right](#align_right)
* [text_separator](#text_separator)
* [ask](#ask)
* [progress](#progress)
* [progressbar](#progressbar)
* [spanner](#spanner)
* [spin](#spin)
* [spinner](#spinner)
* [spinner2](#spinner2)
* [colormsg](#colormsg)
* [error](#error)
* [info](#info)
* [success](#success)
* [warning](#warning)
* [mesg](#mesg)
* [getcolumn](#getcolumn)
* [enquote](#enquote)
* [ruler](#ruler)
* [err](#err)
* [colors2nums](#colors2nums)
* [getColor](#getcolor)
* [colorize-text](#colorize-text)
* [colors2](#colors2)
* [remindme](#remindme)
* [errormsg](#errormsg)

## common helpers

common helper functions to work with scripts

### need

Helper function to check if a given tool is installed, otherwise die

#### Arguments

* **$1** (string): name of the binary
* **$2** (string): additional text to the error message (e.g. where to download)

### apath

Temporarily add to PATH

#### Arguments

* **$1** (string): path to add

### terminal_title

Set terminal title

#### Arguments

* **$1** (string): title of the terminal

### xtitle

Set terminal title

#### Arguments

* **$1** (string): title of the terminal

### open

Open a GUI app from CLI

#### Arguments

* **$1** (string): name of the GUI app

### daemon

Super stealth background launch

#### Arguments

* **$1** (string): command to run in stealth mode

### die

Shell function to exit script with error in exit status and print optional message to stderr

### editcmd

Run a command, redirecting output to a file, then edit the file with $EDITOR

### repeatcmd

Repeats a command every x seconds

#### Arguments

* **$1** (int): PERIOD in s after COMMAND is executed
* **$2** (string): COMMAND to be executed

## text formation

format test in the console

### align_center

center text in console with simple pipe like

#### Arguments

* **$1** (string): text to print

### align_right

right-align text in console using pipe like ( command | right )

#### Arguments

* **$1** (string): text to print

### text_separator

Helper function to separate output with a given character

#### Arguments

* **$1** (string): (optional) character for separation, default is `-`
* **$2** (int): (optional) how much characters to print, default is 80

### ask

Ask user for y/Y

#### Arguments

* **$1** (string): question to display

### progress

outputs dots every second until command completes

### progressbar

show progress bar while running a command
copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (string): process to wait for
* **$2** (string): characters to show in the progress bar

### spanner

show "please wait" while running a command
copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (string): process to wait for

### spin

show moving spinner while running a command
copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (string): process to wait for
* **$2** (string): characters to show in the progress bar

### spinner

show non-moving spinner while running a command
copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (string): process to wait for
* **$2** (string): characters to show in the progress bar

### spinner2

Display a progress process
To start the spinner2 function, you have to send the function
into the background. To stop the spinner2 function, you have
to define the argument "stop".

### colormsg

colorize message in shell

#### Arguments

* **$1** (string): text to colorize

### error

colorize and display error message in shell

#### Arguments

* **$1** (string): text to colorize

### info

colorize and display info message in shell

#### Arguments

* **$1** (string): text to colorize

### success

colorize and display success message in shell

#### Arguments

* **$1** (string): text to colorize

### warning

colorize and display warning message in shell

#### Arguments

* **$1** (string): text to colorize

### mesg

colorize and display message in shell

#### Arguments

* **$1** (string): text to colorize

### getcolumn

Extract a particular column of space-separated output

#### Example

```bash
lsof | getcolumn 0 | sort | uniq
```

#### Arguments

* **$1** (int): number of the column to extract

### enquote

Surround lines with quotes (useful in pipes) - from mervTormel

### ruler

ruler that stretches across the terminal

### err

Determining the meaning of error codes

#### Arguments

* **$1** (int): error code

## colors

work with colors on the terminal

### colors2nums

print all 256 colors for testing TERM or for a quick reference
show numerical values for each of the 256 colors in bash

### getColor

show color for given number

#### Arguments

* **$1** (int): value of the color to show

### colorize-text

takes a name of a color and some text and then echoes out the text in the named color

#### Example

```bash
colorize_text "color" "whatever text"
```

### colors2

displays all 256 possible background colors, using ANSI escape sequences.
author: Chetankumar Phulpagare
used in ABS Guide with permission.

## UI enhancements

functions used within a DE

### remindme

Reminder for whatever whenever

#### Arguments

* **$1** (int): time to sleep in ms
* ä2 string text to show after time has elapsed

### errormsg

used for bash nautilus scripts to show a warning if something goes wrong
use as follows in your scripts
trap errormsg  SIGINT SIGTERM ERR

#### Arguments

* **$1** (string): error message to show

