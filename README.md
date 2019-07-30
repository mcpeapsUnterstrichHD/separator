# Separator - a useful shell script

- Name: sep.sh
- Author: Paul Nadolny, https://github.com/pjnadolny
- Version: 1.0

```
File         Description
-----------  ---------------------------
sep.sh       The separator shell script
LICENSE      GNU GPLv3
unit-test.sh Some informal unit tests
README.md    This file
```

## 1. Purpose
This bash shell script prints a separator line across the
terminal window to visually separate lengthy output from
different commands.  It helps you easily distinguish
output from different commands when you scroll back through
terminal output.

Often you can redirect output to a file and then look at it.
Sometimes it is difficult to do that, or you want to compare output
from adjacent commands, and that's where this separator
script is useful.

## 2. Background
I've used this handy command line tool in various incarnations
over the years.  I finally decided to make a decent version
and share it.  Of course, the script ballooned in size when I added
error checking and other tidbits!

## 3. Details
When coding, I often perform one of the following
sequences over and over:

1. Repeated compilations:
```
$ g++ -o prog prog.cpp
<some compilation messages>
$ edit prog.cpp
$ g++ -o prog prog.cpp
<some compilation messages>
$ edit prog.cpp
```
2. Repeated testing:
```
$ g++ -o prog prog.cpp
$ prog.cpp <test data>
< a bunch of output>
$ edit prog.cpp
$ g++ -o prog prog.cpp
% prog.cpp <test data>
<a bunch of output>
$ edit prog.cpp
```

When scrolling upward to examine compilation messages or output,
it can be hard to see where one command's output ends
and the next begins.

This script prints a line of separator characters across the width
of the terminal window.  It is intended to be used before a command
like this:

```
$ sep.sh; g++ -o prog prog.cpp
---------------------------------------------------------------------------
<some compilation messages>
$ edit prog.cpp
$ sep.sh; g++ -o prog prog.cpp
---------------------------------------------------------------------------
<some compilation messages>
```

This makes it easy to scroll upward until you see the separator line, which
signals the beginning of a command's output.

## 4. Installation
The separator shell script consists of one file: `sep.sh`.
I put the script in my `bin` directory, which is in my `PATH`.

## 5. Usage
```
$ sep.sh --help
Usage: sep.sh [ --box <n> | --help | --sep <s> | --version ]
  -b, --box <n>  Print <n> big boxes (<n> in [1,9])
  -h, -?, --help Print this usage message
  -s, --sep <s>  Print repeated separator character(s) <s>
  -v, --version  Print the version
  if no argument, print a separator line of dashes
```
### 5.1 With no arguments
With no arguments, it simply prints a line of dashes that is 5 less than the
current terminal width.
```
$ sep.sh; g++ -o prog prog.cpp
---------------------------------------------------------------------------
<some compilation messages>
```

### 5.2 Argument: `--sep <s>` or `-s <s>`

With an argument of `--sep <s>`, it prints a customized
separator composed of repeated `<s>`, where `<s>` is one
or more characters.
The width is at most 5 characters less than the current terminal width.
```
$ sep.sh -s =; g++ -o prog prog.cpp
===========================================================================
<some compilation messages>
```

```
$ sep.sh -s +-; g++ -o prog prog.cpp
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
<some compilation messages>
```

```
$ sep.sh -s \<\>-; g++ -o prog prog.cpp
<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-<>-
<some compilation messages>
```

```
$ sep.sh -s -output-; g++ -o prog prog.cpp
-output--output--output--output--output--output--output--output--output-
<some compilation messages>
```

```
$ sep.sh -s 'Unit Test 7 -- '; prog < unit-test-7.txt
Unit Test 7 -- Unit Test 7 -- Unit Test 7 -- Unit Test 7 -- Unit Test 7 --
<some testing messages>
```

### 5.3 Argument: `--box <n>` or `-b <n>`

With an argument of `--box <n>`, it prints a separator made of big boxes.
The integer specifies the number of big boxes.
The integer must be from 1 to 9 inclusive.
(Note: it may print fewer big boxes if the full amount will not fit
the width of the terminal.)

This option has helped me keep my sanity during many late night
coding sessions!

```
$ sep.sh -b 1; grep char README.md; sep.sh -b 2; grep sep README.md
+---+
|\ /|
| 1 |
|/ \|
+---+
This script prints a line of separator characters across the width
  -s, --sep <s>  Print repeated separator character(s) <s>
or more characters.
The width is at most 5 characters less than the current terminal width.
$ sep.sh -b 1; grep char README.md; sep.sh -b 2; grep sep README.md
The disadvantage is you lose the ability to change the separator character(s) at will.
+---+---+
|\ /|\ /|
| 2 | 2 |
|/ \|/ \|
+---+---+
Name | `sep.sh`
This bash shell script prints a separator line across the
terminal window to visually separate lengthy output from
Sometimes it is difficult to do that, and that's where this separator
This script prints a line of separator characters across the width
$ sep.sh; g++ -o prog prog.cpp
$ sep.sh; g++ -o prog prog.cpp
This makes it easy to scroll upward until you see the separator line, which
The separator shell script consists of one file: `sep.sh`.
```

### 5.4 As Part of the Command Prompt
You can call the separator script from the command prompt itself.
The advantage of this approach is that you don't need to remember
to issue the separator command each time.
The disadvantage is you lose the ability to change the separator character(s) at will.
```
$ export PROMPT_COMMAND="$PROMPT_COMMAND; ~/bin/sep.sh"
---------------------------------------------------------------------------
$ echo 'Hello, world!'
Hello, world!
---------------------------------------------------------------------------
$ seq 3 1
3
2
1
---------------------------------------------------------------------------
$
```

## 6. Notes
I developed this script on MacOS High Sierra 10.13.6,
using `/bin/bash` version:
`GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin17)`

To do: make options (`--width`, `--margin`)
to customize the width of the separator line.

To do: support multiple options at the same time.

## 7. Feedback
I welcome civil comments, fixes, improvements, constructive criticisms,
suggestions, etc.
