#!/bin/bash

# Run enhanced queries (44-60) with JOIN operations

TRIES=3

# Extract only the JOIN queries (lines 44-60)
tail -n +44 queries_enhanced.sql | head -n 17 | while read -r query; do
    if [ -n "$query" ] && [[ ! "$query" =~ ^[[:space:]]*$ ]] && [[ ! "$query" =~ ^-- ]]; then
        sync
        echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null

        for i in $(seq 1 $TRIES); do
            mysql -vvv -h127.1 -P9030 -uroot hits -e "${query}"
        done
    fi
done
