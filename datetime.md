# datetime.sh

## Overview

helper functions for date and time

## Index

* [normal2unix](#normal2unix)
* [unix2normal](#unix2normal)
* [sec2all](#sec2all)
* [seconds-convert-part](#seconds-convert-part)

## aliases for date and tiem

Information (clock and date stuff)

### normal2unix

convert normal to unix

#### Arguments

* **$1** (string): normlatime

### unix2normal

convert unix to normal

#### Arguments

* **$1** (string): unixtime

### sec2all

convert seconds to minutes, hours, days, and etc.
inputs a number of seconds, outputs a string like "2 minutes, 1 second"

#### Arguments

* **$1** (int): number of seconds

### seconds-convert-part

formats a time unit into a string

#### Arguments

* **$1** (int): integer count of units: 0, 6, etc
* **$2** (string): unit name: "hour", "minute", etc

