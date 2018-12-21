#!/bin/bash
DIR=~/.donetoday

function usage {
    echo "Usage:"
    echo "- Add a task for today: donetoday \"I've done this\""
    echo "- Add a task for a given day: donetoday 20181220 \"I've done this\""
    echo "- View tasks of today: donetoday"
    echo "- View tasks of a given day: donetoday 20181221"
    echo "- Help: donetoday -h"
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

# If first parameter is a date, display content of that date or add new content
if [[ $FIRSTPARAM =~ ^[0-9]{8}$ ]]; then
    FILEPATH=$DIR/${FIRSTPARAM:0:4}/${FIRSTPARAM:4:4}.txt
    if [ -z ${2+x} ]; then
        # No parameter behind date, display date content
        if [ ! -f $FILEPATH ]; then
            echo "No tasks found for date $FIRSTPARAM"
            exit 1
        else
            echo "Done $FIRSTPARAM"
            echo "----------"
            cat $FILEPATH
            echo "----------"
            exit 0
        fi
    else
        # Add new task to this day
        addtask $FIRSTPARAM "$2"
        exit 0
    fi
else
    addtask $YEAR$DATE "$1"
    exit 0
fi
