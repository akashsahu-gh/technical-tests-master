# Test 1: multi-stage docker
Updated Dockerfile at https://github.com/akashsahu-gh/technical-tests-master/blob/master/Test1/Dockerfile

# Test 2:
Application program is written in Python language and CI Setup is done in Google Cloud Platform project.
Below GCP services are used to setup Application
1. Cloud Build --> To create image and deploy via Cloud run 
2. Container Registry --> To store application docker image 
3. Cloud Run --> Run the container image in CI/CD setup with new commit in GitHub Branch. 

For CI/CD below actions will be taken by Cloud Build once commit/push has happened in GitHub Branch.
1. Create new Docker Container image
2. Push Container image to Google Container Registry
3. Cloud Run will run another revision from new container image and traffic will be slowly diverted to new revision and old revision will be stopped.

API can be accessed at endpoint /api/version post deployment, for ex. https://asahu-anz-catye5wxda-ts.a.run.app/api/version

Note: By Default, Cloud Run will have Authentication enabled via IAM therefore no public access. Authentication can be disabled which will make URL accessible to public internet, [enable public access](https://github.com/akashsahu-gh/technical-tests-master/blob/master/README.md#enable-public-accessperform-either-of-the-below-steps)  

# Steps to setup application in a GCP Project 
1. Create Project & Enable api's via CloudShell 
Run below Commands from Google Cloud Shell 

export PROJECT_ID=<unique project id>  

==> Create Project    
gcloud projects create $PROJECT_ID --enable-cloud-apis  

Attach a billing account to the Project created from Cloud Portal https://cloud.google.com/billing/docs/how-to/modify-project     


==> Set Project in cloud shell   
gcloud config set project $PROJECT_ID   

==> Enable API services   
gcloud services enable cloudbuild.googleapis.com   
gcloud services enable containerregistry.googleapis.com   
gcloud services enable run.googleapis.com   

==> Grant required access to Cloud Build Service Account   
sa_name=$(gcloud projects get-iam-policy $PROJECT_ID --format="json" | jq '. ["bindings"][] | select ( .role | contains("cloudbuild.builds")) .members[]'| tr -d '"' )   
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$sa_name --role=roles/run.admin   
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$sa_name --role=roles/iam.serviceAccountUser   

![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/runbook_snippet1.PNG)
![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/runbook_snippet2.PNG)


2. Add repository to Cloud Build ==> https://cloud.google.com/cloud-build/docs/automating-builds/run-builds-on-github#connecting_additional_repositories   

Repository URL to be added: https://github.com/akashsahu-gh/technical-tests-master.git   
You would need any github creds to add the Repo in Cloud Build.

Go to ==> GCP Console --> Cloud Build --> Triggers --> Connect Repository 

![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/build1.PNG)
![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/build2.PNG)
![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/build3.PNG)


3. Deploy build trigger in Cloud Build 
Go to ==> GCP Console --> Cloud Build --> Triggers --> Create Trigger

Name: anz-test   
Event: Push to a Branch   
Source: Select the repo added in Step 2   
FileType: Leave to Autodetected   

![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/trigger1.PNG)
![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/trigger2.PNG)   


Run/Commit the branch to trigger the Build. 
![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/trigger3.PNG)   



# Access the application via curl command from gcloud   

SERVICE_URL=$(gcloud run services list --platform managed --format="value(URL)")   
curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" $SERVICE_URL   
curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" $SERVICE_URL/api/version  

![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/final_op1.PNG)
![alt text](https://github.com/akashsahu-gh/technical-tests-master/blob/master/images/final_op2.PNG)


# Enable public access,perform either of the below steps

1. Uncomment line 9 (,'--allow-unauthenticated' ) from cloudbuild.yaml file in repo https://github.com/akashsahu-gh/technical-tests-master/blob/master/cloudbuild.yaml
2. Grant all users access to Cloud Run invoker role   
SERVICE_NAME=$(gcloud run services list --platform managed --format="value(SERVICE)")  
gcloud run services add-iam-policy-binding $SERVICE_NAME --platform managed --member="allUsers" --role="roles/run.invoker" --region australia-southeast1  