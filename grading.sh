#!/bin/bash
EXPECTED_OUTPUT="$1"
STUDENT_OUTPUT="$2"

while read -r WUSTL_KEY; do
    git clone "https://github.com/CSE237SP25/$WUSTL_KEY.git"
    cd "$WUSTL_KEY" 
    git checkout cipher
    git checkout "$(git log -1 --before="2026-02-12 10:00:00 -0600" --format="%H" HEAD)"

    javac Cipher.java
    java Cipher > "$STUDENT_OUTPUT"

    SCORE=0
 
    if [ -f "$STUDENT_OUTPUT" ]; then
        
        if  [$(diff $STUDENT_OUTPUT $EXPECTED_OUTPUT)] ; then
            SCORE=1
        fi
    fi
    
    echo "$WUSTL_KEY: $SCORE"
 
    cd ..
done
