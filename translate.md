# translate.sh

## Overview

helper functions to translate text via console -- to be verified

## Index

* [dic](#dic)
* [ref](#ref)
* [wordnet](#wordnet)
* [define](#define)
* [detectlanguage](#detectlanguage)

### dic

Lookup a word with dict.org

#### Arguments

* $# string word to lookup

### ref

find matches of $1, with optional strat $2 and optional db $3

#### Arguments

* **$1** (string): to find
* **$2** (string): Search type
* **$3** (string): db

### wordnet

Lookup a word with dict.org in WordNet

#### Arguments

* **$1** (string): word to lookup

### define

define a word

#### Example

```bash
define dog
```

### detectlanguage

detect language of a string

