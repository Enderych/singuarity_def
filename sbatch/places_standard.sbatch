#!/bin/bash 

  

#### 

#a) Define slurm job parameters 

#### 

  

#SBATCH --job-name=places_std

  

#resources: 

  

#SBATCH --cpus-per-task=6

# the job can use and see 6 CPUs (from max 24). 

  

#SBATCH --partition=week

# the slurm partition the job is queued to. 

  

#SBATCH --mem-per-cpu=12G 

# the job will need 12GB of memory equally distributed on 4 cpus.  (251GB are available in total on one node) 

  

#SBATCH --gres=gpu:1080ti:4 

#the job can use and see 1 GPUs (4 GPUs are available in total on one node) 

  

#SBATCH --time=7-00:00:00 

# the maximum time the scripts needs to run 

  

#SBATCH --error=job.%cvusa0301p.err 

# write the error output to job.*jobID*.err 

  

#SBATCH --output=job.%cvusa0301p.out 

# write the standard output to job.*jobID*.out 

  

#SBATCH --mail-type=ALL 

#write a mail if a job begins, ends, fails, gets requeued or stages out 

  

#SBATCH --mail-user=chenhao.yang@uni-tuebingen.de 

# your mail address 

  

#### 

#b) copy all needed data to the jobs scratch folder 

#### 

  

cp -r ~/cross_view/Places/places365 /scratch/$SLURM_JOB_ID/ 
cp -r ~/places_data/places365_standard /scratch/$SLURM_JOB_ID/

  

#### 

#c) Execute your tensorflow code in a specific singularity container 

#d) Write your checkpoints to your home directory, so that you still have them if your job fails 

#cnn_minst.py <model save path> <mnist data path> 

#### 

  

singularity exec --nv ~/myImages/SingularityImages/TCML-Cuda9_0Tensorflow1_12_torch04.simg python /scratch/$SLURM_JOB_ID/places365/train_placesCNN.py -a resnet18 /scratch/$SLURM_JOB_ID/places365_standard

  

#### 

#e)copy output result back to account document 

#### 

  

cp -r /scratch/$SLURM_JOB_ID/places365 ~/outputs


  

echo DONE! 
