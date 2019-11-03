#!/bin/bash
DIR=~/.donetoday

function usage {
    echo "Usage:"
    echo "- Add a task for today:            donetoday \"I've done this\""
    echo "- Add several tasks for today:     donetoday \"I've done this\" \"I've done that\""
    echo "- Add a task for a given day:      donetoday 20181220 \"I've done this\""
    echo "- Add a task for a day before:     donetoday -1 \"I've done this\""
    echo "- View tasks of today:             donetoday"
    echo "- View tasks of a given day:       donetoday 20181221"
    echo "- View tasks of N previous days:   donetoday show N"
    echo "- Help:                            donetoday -h"
    echo "Storage directory:"
    echo $DIR
}

function addtask {
    # To be called with $1=date $2=content
    YEAR=${1:0:4}
    DATE=${1:4:4}

    # Create path
    mkdir -p $DIR/$YEAR
    echo $2 >> $DIR/$YEAR/$DATE.txt

    # Done
    echo "Added $2."
    echo "Good job!"
    echo ""
}

function showday {
    # Usage $1=date
    # No parameter behind date, display date content
    FILEPATH=$DIR/${1:0:4}/${1:4:4}.txt
    if [ ! -f $FILEPATH ]; then
        echo "No tasks found for date $1"
    else
        echo "Done $1"
        echo "-------------"
        cat $FILEPATH
    fi
}

# Create main dir
mkdir -p $DIR

# Get date values
YEAR=`date +"%Y"`
DATE=`date +"%m%d"`
FIRSTPARAM=$1

# If no parameters given, display tasks done today
if [ "$#" -lt 1 ]; then
    FIRSTPARAM=`date +"%Y%m%d"`
fi

# Display help
if [[ $FIRSTPARAM == "-h" ]]; then
    usage
    exit 0
fi

# If first parameter is -N where N is a number, convert it to date
if [[ $FIRSTPARAM =~ ^\-[0-9]$ ]]; then
    FIRSTPARAM=`date +%Y%m%d -d "${FIRSTPARAM:1:1} day ago"`
fi

# If first parameter is a date, display content of that date or add new content
if [[ $FIRSTPARAM =~ ^[0-9]{8}$ ]]; then
    if [ -z ${2+x} ]; then
        showday $FIRSTPARAM
        exit 0
    else
	    varnum=0
        for var in "$@"
        do
	        varnum=$((varnum+1))
	        if [ $varnum -lt 2 ]; then
		        continue
	        fi
            # Add new task to this day
            addtask $FIRSTPARAM "$var"
        done
        exit 0
    fi
fi

# Show multiple days
if [[ "$FIRSTPARAM" == "show" ]]; then
    NUMDAYSTOSHOW=$2
    for i in $(seq 0 1 $2)
    do
        DATETOSHOW=`date +%Y%m%d -d "$i day ago"`
        showday $DATETOSHOW
        echo
    done
    exit 0
fi

# If not show
if [ "$#" -ge 2 ]; then
    for var in "$@"
    do
        addtask $YEAR$DATE "$var"
    done
    exit 0
fi

# Other cases, display help
usage
exit 0
