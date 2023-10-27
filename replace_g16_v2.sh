 #!/bin/bash
job1=$1
job2=$2
functional=$3
base=$4
ScriptDir="$(dirname "$0")"
for file in *.gjf; do
       sed -i "/^#/ s/#.*/# $job1 $job2 $functional\/$base empiricaldispersion\=gd3bj scrf\=(\solvent\=acetonitrile,pcm) guess\=mix/" $file
       sed -i 's/\r//' $file
done

