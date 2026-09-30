#!/bin/bash

PID=$1
OUT=$2

while kill -0 "$PID" 2>/dev/null; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    ps -p "$PID" \
       -o pid=,%cpu=,%mem=,rss=,vsz= \
       | awk -v time="$TIMESTAMP" \
       '{printf "[%s] PID:%s CPU:%s%% MEM:%s%% RSS:%.2fMB VSZ:%.2fMB\n", \
       time, $1, $2, $3, $4/1024, $5/1024}' \
       | tee -a "$OUT"

    sleep 1
done

echo "[$(date '+%Y-%m-%d %H:%M:%S')] PROCESS EXITED" | tee -a "$OUT"
