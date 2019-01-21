# Done Today

A script to store tasks done today (or any other day). Keep track of your progress.

# Installation

Done Today is a bash script. Download it, give it execution rights and run it. Alternatively you can put it (or a symbolic link) to a folder which is in your path.

```
chmod u+x donetoday.sh
./donetoday.sh
```

```
cp donetoday.sh /path/in/my/PATH/var/donetoday
donetoday
```

This has been tested only on Linux Ubuntu.

# Usage

- Add a task for today:            `donetoday "I've done this"̀`
- Add a task for a given day:      `donetoday 20181220 "I've done this"`
- Add a task for a day before:     `donetoday -1 "I've done this"`
- View tasks of today:             `donetoday`
- View tasks of a given day:       `donetoday 20181221`
- View tasks of N previous days:   `donetoday show N`
- Help:                            `donetoday -h`

```
~$ donetoday
No tasks found for date 20181221
~$ donetoday "Read Docker documentation"
Added Read Docker documentation.
Good job!
~$ donetoday "Called mom"
Added Called mom.
Good job!
~$ donetoday
Done 20181221
----------
Read Docker documentation
Called mom
----------
~$ donetoday 20181220 "Read two chapters of book X"
Added Read two chapters of book X.
Good job!
~$ donetoday 20181220
Done 20181220
----------
Read two chapters of book X
----------

```

# Implementation

This script creates a folder ~/.donetoday. Each day is a file under a year subfolder.

```
~/.donetoday/
~/.donetoday/2018
~/.donetoday/2018/1221.txt
~/.donetoday/2018/1220.txt
```

This script is a helper to manipulate these folder easily
