# strings.sh

## Overview

helper functions for working with strings

## Index

* [string2bin](#string2bin)
* [lcfirst](#lcfirst)
* [ltrim](#ltrim)
* [rtrim](#rtrim)
* [strim](#strim)
* [strtolower](#strtolower)
* [strtoupper](#strtoupper)
* [trim](#trim)
* [strucfirst](#strucfirst)
* [strucwords](#strucwords)

### string2bin

converts a string (words, text) to binary"

#### Arguments

* **$1** (string): value to convert

### lcfirst

Convert the first letter into lowercase letters

#### Arguments

* **$1** (string): string to change

#### Exit codes

* string whhere first letter is lowercase

### ltrim

Remove whitespace at the beginning of a string

#### Example

```bash
echo "   That is a sentinece" | rtrim
```

#### Arguments

* **$1** (string): string from which to remove whitespaced

#### Exit codes

* string w/o whitespaces at the beginning of the string

### rtrim

Remove whitespace at the end of a string

#### Example

```bash
echo "That is a sentinece " | rtrim
```

#### Arguments

* **$1** (string): string from which to remove whitespaced

#### Exit codes

* string w/o whitespaces at the end

### strim

Cut a string after X chars and append three points

#### Example

```bash
strim averylongstring 2
```

#### Arguments

* **$1** (string): string to shortened/cut
* **$2** (int): length of the string

#### Exit codes

* shortened string

### strtolower

Convert all alphabetic characters to lowercase

#### Arguments

* **$1** (string): string to convert

### strtoupper

Convert all alphabetic characters converted to uppercase

#### Arguments

* **$1** (string): string to convert

### trim

Remove whitespace at the beginning and end of a string

#### Example

```bash
echo " That is a sentinece " | trim
```

#### Arguments

* **$1** (string): string to convert

### strucfirst

Convert the first letter into uppercase letters

### strucwords

Converts first letter of each word within a string into an uppercase, all other to lowercase

