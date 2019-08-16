# Picat syntax highlighting for Sublime Text 3 #
# This Picat with a highlighting syntax is for Sublime Text 3
# Without ANY warranty of this process and files configuration
# I did it based in the Prolog package for Sublime

1. Copy the directory: https://github.com/claudiosa/CCS/blob/master/picat/sublime-text-3/Picat/
Use a wget to do it ...
For example wget -????? sublimepicat.tar.gz https://....
In Picat/ contains  all the configuration for Picat's syntax (I am working on it)


2. Copy only this directory Picat/ in ~/.config/sublime-text-3/Packages/

3. Re-starts, if it is the case, the Sublime 


OLD method for installation:

1. Copy the content from this Directory -- https://github.com/claudiosa/CCS/tree/master/picat/sublime-text-3/
It contains the directory Picat/
where is all the configuration for Picat's syntax (I am working on it)

2. There is a directory called "Picat", copy it  in  ~/.config/sublime-text-3/Cache/
   or move  this directory picat/ ....  with all the pre-defined languages in Cache/
   Example: cp -R Picat/  ~/.config/sublime-text-3/Cache/
   or cp -r Picat/  ~/.config/sublime-text-3/Cache/

3. Starts the Sublime with a Picat file
   (this procedure works fine)

ANY IMPROVEMENTS are wellcome 

Claudio Sá -- ccs1664@gmail.com


#############################################################################
#### ALMOST ORIGINAL


# Prolog syntax highlighting for Sublime Text 2 & 3 #

This package provides syntax highlighting and automated build for the logic
programming language Prolog. It is highly work in progress, so use with care.

## Auto Build System ##
To be able to use the <kbd>Ctrl</kbd>+<kbd>B</kbd> automatic build, you need to define `main/0`
where you compute the solution and you also print it. For example:

```picat
main :- compute(input, Solution), writef('%t\n', [Solution]).
```

An indicator that this is not done (correctly) is the following error:

```
ERROR: call/2: Undefined procedure: main/1
ERROR:   However, there are definitions for:
ERROR:         main/0
```

## Installation ##

### Installation via Sublime Package Control ###

I recommend using the [Sublime Package Control] [1] to install this package. 
This way is much more convenient. It is named *Prolog*.

[1]: http://wbond.net/sublime_packages/package_control

### Manual installation ###

If you want to manually install this package, please do:

```sh
cd /tmp
wget -O sublimepicat.tar.gz http://github.com/alnkpa/sublimepicat/tarball/master
tar -xzvf sublimepicat.tar.gz
cd alnkpa-sublimepicat-<commit>
mv Prolog.tmLanguage ~/.config/sublime-text-2/Packages/User/
```

## License ##

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at <http://mozilla.org/MPL/2.0/>.
