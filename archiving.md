# archiving.sh

## Overview

helper functions to work with archives

## Index

* [extract](#extract)
* [pullout](#pullout)
* [compression_level](#compression_level)
* [mktar](#mktar)
* [mktbz](#mktbz)
* [mktgz](#mktgz)
* [mkzip](#mkzip)

### extract

archive wrapper to automatically select the right command for the given archive type

#### Arguments

* **$1** (string): name fo the archive to extract

### pullout

Pull a single file out of a .tar.gz

#### Arguments

* **$1** (string): name fo the archive
* **$1** (string): name fo the file to extract from archive

### compression_level

Sets the compression level for file-roller

### mktar

Creates a tar archive from directory

#### Arguments

* **$1** (string): directory to archive

### mktbz

Creates a bz archive from directory

#### Arguments

* **$1** (string): directory to archive

### mktgz

Creates a gz archive from directory

#### Arguments

* **$1** (string): directory to archive

### mkzip

Creates a zip archive from directory

#### Arguments

* **$1** (string): directory to archive

