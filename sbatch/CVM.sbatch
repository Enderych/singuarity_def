#!/bin/bash 

  

#### 

#a) Define slurm job parameters 

#### 

  

#SBATCH --job-name=cvm 

  

#resources: 

  

#SBATCH --cpus-per-task=6 

# the job can use and see 6 CPUs (from max 24). 

  

#SBATCH --partition=week

# the slurm partition the job is queued to. 

  

#SBATCH --mem-per-cpu=8G 

# the job will need 12GB of memory equally distributed on 4 cpus.  (251GB are available in total on one node) 

  

#SBATCH --gres=gpu:1080ti:4 

#the job can use and see 1 GPUs (4 GPUs are available in total on one node) 

  

#SBATCH --time=7-00:00:00 

# the maximum time the scripts needs to run 

  

#SBATCH --error=job.%cvm0222.err 

# write the error output to job.*jobID*.err 

  

#SBATCH --output=job.%cvm0222.out 

# write the standard output to job.*jobID*.out 

  

#SBATCH --mail-type=ALL 

#write a mail if a job begins, ends, fails, gets requeued or stages out 

  

#SBATCH --mail-user=chenhao.yang@uni-tuebingen.de 

# your mail address 

  

#### 

#b) copy all needed data to the jobs scratch folder 

#### 

  

cp -r ~/cross_view/ /scratch/$SLURM_JOB_ID/ 

  

#### 

#c) Execute your tensorflow code in a specific singularity container 

#d) Write your checkpoints to your home directory, so that you still have them if your job fails 

#cnn_minst.py <model save path> <mnist data path> 

#### 

  

singularity exec --nv /common/singularityImages/TCML-Cuda9_0Tensorflow1_12.simg python3 /scratch/$SLURM_JOB_ID/cross_view/src/CVM-Net/train.py

  

#### 

#e)copy output result back to account document 

#### 

  

cp -r /scratch/$SLURM_JOB_ID/cross_view/src/Model/ ~/cross_view/src/out
cp -r /scratch/$SLURM_JOB_ID/cross_view/src/Result/ ~/cross_view/src/out

  

echo DONE! 
