# math.sh

## Overview

helper functions for mathematics and number manipulation

## Index

* [nseq](#nseq)
* [sqrt](#sqrt)
* [trig-angle](#trig-angle)
* [round](#round)
* [arabic2roman](#arabic2roman)
* [avg](#avg)
* [collatz](#collatz)
* [brownian](#brownian)
* [random](#random)
* [power](#power)
* [factorial](#factorial)
* [math-log](#math-log)

### nseq

list of numbers with equal width i.e. number with 0-prefixed

#### Arguments

* **$1** (int): numbers to print

### sqrt

finding the square root of numbers

#### Arguments

* **$1** (int): numbers to use for calc

### trig-angle

trigonmetry calculations with angles

### round

round numerals to whole numbers
copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (number): number to round
* **$2** (int): digits to round to

### arabic2roman

convert arabic to roman numerals
Copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (int): number to convert

### avg

Averaging columns of numbers
Computes a columns average in a file

#### Arguments

* **$1** (int): column number
* **$2** (string): optional pattern

### collatz

the notorious "hailstone" or Collatz series.

#### Arguments

* **$1** (int): seed number

## Randomness

functions dealing with randmoness

### brownian

This script models Brownian motion:
random wanderings of tiny particles in fluid, as they are buffeted
by random currents and collisions (colloquially known as "Drunkard's Walk")
Author: Mendel Cooper

### random

random number (out of whatever you input)
copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (string): [optional] `-L` or `-r` 
* **$2** (int): value

### power

calculate powers of numerals
copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (int): base number
* **$2** (int): optional power (default is 2)

### factorial

calcutale factorial of an integer

### math-log

finding logs for numbers

