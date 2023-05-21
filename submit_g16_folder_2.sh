#!/bin/bash
ScriptDir="$(dirname "$0")"
for file in *.gjf; do
    sh $ScriptDir/submit_g16_v2.sh $file $1 $2 $3 $4
done