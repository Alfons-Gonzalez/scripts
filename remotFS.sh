#!/bin/sh
#
# SLURM parameters

# set the partition where the job will run
#SBATCH --partition=normal
# set the number of nodes
#SBATCH --nodes=1
# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL
# send mail to this address
#SBATCH --mail-user=alfons.gonzalez@upf.edu

# carreguem el modul per executar fastqc
module load FastQC
# carreguem el modul sshfs
module load sshfs
# creem el mountpoint si no hi es
if [ ! -d extern ] ; then mkdir extern;fi
# muntem el directori extern
sshfs alfons@rabat.prib.upf.edu:/projects_fg/test_by_alfons extern
# executem el fastqc fent input i output al sshfs
cd extern
if [ ! -d results ] ; then mkdir results;fi
fastqc -o results Phix_S1_L001_R1_001.fastq.gz Phix_S1_L002_R1_001.fastq.gz
#
# sortim i desmuntem
cd
fusermount3 -u extern
# final
exit 0


