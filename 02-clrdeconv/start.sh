#!/bin/sh
set -e
trap '[ -z "$PID" ] || kill $PID' EXIT
for SIGNAL in INT TERM HUP; do
    trap '[ -z "$PID" ] || kill -$SIGNAL $PID' $SIGNAL
done
python3 deepzoom_server.py -l 0.0.0.0 -p 5000 --pigment hematoxylin "$@" & PID="$!"
python3 deepzoom_server.py -l 0.0.0.0 -p 5001 --pigment eosin "$@" & PID="$PID $!"
python3 deepzoom_server.py -l 0.0.0.0 -p 5002 --pigment dab "$@" & PID="$PID $!"
wait $PID