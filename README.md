# my-app

# Part 1

Here is the Jenkins file in the repo with jobs to : CheckOut, Test Code, Build , Test , Security scan and publish Code to maven repo

I have updated pom.xml . Also settings.xml will be update for private maven repo username and passowrds

There will be setting requires as adding the plugins for SonarQube and Private Maven Repo (which can be of choice) and adding the end points and username for same


# Part2

In order to keep the development going . The suggestion is to maintain the various versions for Jenkins file and asking using the latest one in the pipeline .Jenkins gives the option to directly pick the jekinsfile from repo which can be configured in pipeline 


# Part 3

As per the requirement of the Disaster recovery for the Jenkins setup . I have created a docker file to create a desired image with plugins and other settings . By using the docker image in deployment.yaml for Jenkins server we can spin desired Jenkins setup at any point of time.

Currently i have added only plugin information in docker file . There would be many more sceanarion like adding the initial user and other settings as well for that we need to upadte the docker image like for eg. in case of configuring the admin user we would require to COPY user details in image via yaml file


In order to have full setup . Here are the steps we would require to follow:

1. Build the dockerfile to create jenkins Image (with plugins and settings)
2. Publish the image in private container Registry
3. Use the new image in deployment and Deploy the Jenkins and Jenkins-service in Kubernetes cluster via pipeline

