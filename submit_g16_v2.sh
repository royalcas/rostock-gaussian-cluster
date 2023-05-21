#!/bin/bash
base=`basename $1 .gjf`
script=$base.sh

# Process Variables Definition
NODES=${4:-1}
CORE_AMOUNT=${2:-32}
EXECUTION_TIME=${3:-72:00:00}

echo "Executing "$1" with parameters -core"$CORE_AMOUNT" -time "$EXECUTION_TIME" -nodes"
echo "#!/bin/bash" > $script
echo "#SBATCH -J $base" >> $script

export ClusterMemory=`grep '%mem' $1 | awk -F= '{ print$2 }' | tr -d '\r' | tr '[:upper:]' '[:lower:]'`
export ClusterMemoryGB=$(basename $ClusterMemory gb)
export MemoryPerCore=$(echo "$ClusterMemoryGB*1024/$CORE_AMOUNT" | bc)
echo '#SBATCH -n'$CORE_AMOUNT >> $script
echo '#SBATCH --mem-per-cpu='$MemoryPerCore >> $script
echo '#SBATCH -p compute' >> $script
echo '#SBATCH --nodes='$NODES >> $script
echo '#SBATCH --time='$EXECUTION_TIME >> $script


echo '#SBATCH --mail-type=FAIL,END' >> $script
echo '#SBATCH --mail-user=gustavo.usuga@uni-rostock.de' >> $script

#echo '#PBS -l nodes='$3':ppn='$2',mem='$Cluster_Memory',pmem='$core_mem'mb,walltime='$4 >> $script
echo '. /home/ga1017/bin/g16.profile' >> $script

echo 'cd '`pwd` >> $script
echo 'mkdir -p /scratch/ga1017/gaussian/${base}' >> $script
echo 'export GAUSS_SCRDIR=\"/scratch/ga1017/gaussian/${base}\"' >> $script

echo "g16 $1" >> $script
echo 'if [ -d ${MYSCRATCH} ]; then' >> $script
  echo 'rm -rf ${MYSCRATCH}' >> $script
  echo "echo "Removed ${MYSCRATCH}"" >> $script
echo "fi" >> $script

echo "exit 0" >> $script

sbatch $script 