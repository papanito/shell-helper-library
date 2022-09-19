# security

## Overview

helper functions related to security

## Index

* [randompw](#randompw)
* [sitepass](#sitepass)
* [sitepass2](#sitepass2)
* [encrypt](#encrypt)
* [rot13](#rot13)
* [rot47](#rot47)
* [exportmykeys_private](#exportmykeys_private)
* [exportmykeys_public](#exportmykeys_public)
* [gpg_restoremykeys](#gpg_restoremykeys)

## Passwording

helper functions for secure passwords

### randompw

generate a random password
copyright 2007 - 2010 Christopher Bratusek

#### Arguments

* **$1** (int): number of characters; defaults to 32
* **$2** (int): include special characters; 1 = yes, 0 = no; defaults to 1

### sitepass

generate a unique and secure password for every website that you login to

### sitepass2

generates a unique and secure password with SALT for every website that you login to

## Encryption / decryption

helper functions for encryption and decryption

### encrypt

More advanced encryption / decryption

#### Example

```bash
encrypt filename
decrypt filename
```

### rot13

rot13 ("rotate alphabet 13 places" Caesar-cypher encryption)

#### Arguments

* **$1** (string): text to encypher

### rot47

rot47 ("rotate ASCII characters from '!" to '~' 47 places" Caesar-cypher encryption)

#### Arguments

* **$1** (string): text to encypher

## OpenPGP/GPG

OpenPGP/GPG pubkeys stuff (for Launchpad / etc.

### exportmykeys_private

to export private OpenPGP keys to a file for safe keeping and potential restoration
using 'mykeys', put the appropriate GPG key after you type this function

### exportmykeys_public

to export public OpenPGP keys to a file for safe keeping and potential restoration
using 'mykeys', put the appropriate GPG key after you type this function

### gpg_restoremykeys

to restore your public and private OpenPGP keys
from Public_Key-public.key and Private_Keys-private.key files:

