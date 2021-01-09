# Test 1: multi-stage docker
Updated Dockerfile at https://github.com/akashsahu-gh/technical-tests-master/blob/master/Test1/Dockerfile

# Test 2:
Application program is written in Python language and CI Setup is done in Google Cloud Platform project

# Steps to setup application in a GCP Project 
1. Create Project & Enable api's via CloudShell 
Run below Commands from Google Cloud Shell 
    export PROJECT_ID=abcd-2022
--> Create Project
    gcloud projects create $PROJECT_ID --enable-cloud-apis

Attach a billing account to the Project created from Cloud Portal https://cloud.google.com/billing/docs/how-to/modify-project


--> Set Project in cloud shell
    gcloud config set project $PROJECT_ID

--> Enable API services 
    gcloud services enable cloudbuild.googleapis.com
    gcloud services enable containerregistry.googleapis.com
    gcloud services enable run.googleapis.com

2. Add reposiotru to Cloud Build
--> Add repository to cloud Build (refer images and arcticle for details ) https://cloud.google.com/cloud-build/docs/automating-builds/run-builds-on-github#connecting_additional_repositories
build1 images





1. Create a Service account with Project Owner privs to be used by terraform to provision "Cloud Run", which will host our docker image of application.
3. Add GitHub repo to Cloud Build 

create docker image
push docker image to google container registry 
create cloud run service via terraform 

# Steps to setup CI for Applilcation in GCP Project