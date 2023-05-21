#!/bin/bash
#SBATCH -J optfreq_tpss_cul0ohcmohchdr_eq_cf2_sing
#SBATCH -n32
#SBATCH --mem-per-cpu=0
#SBATCH -p compute
#SBATCH --nodes=1
#SBATCH --time=72:00:00
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=gustavo.usuga@uni-rostock.de
. /home/ga1017/bin/g16.profile
cd /home/ga1017/bin
mkdir -p /scratch/ga1017/gaussian/${base}
export GAUSS_SCRDIR=\"/scratch/ga1017/gaussian/${base}\"
g16 optfreq_tpss_cul0ohcmohchdr_eq_cf2_sing.gjf
if [ -d ${MYSCRATCH} ]; then
rm -rf ${MYSCRATCH}
echo Removed 
fi
exit 0
