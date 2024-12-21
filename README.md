# Task: Automating Deployment with Jenkins, Docker, Vagrant, and Ansible

This repository contains a complete setup for automating the deployment of a Python application using Jenkins, Docker, Vagrant, and Ansible. The project involves the following steps:

---



1. **Push Python Code to GitHub Private Repository** 

2. **Write a Dockerfile** (to containerize the Python application and push it to your repository)

3. **Set Up Vagrant Machines** (to serve as the target environment)

4. **Jenkins Pipeline** to

   - Pull code from the GitHub repository (requires token-based authentication).
   - Build a Docker image for the Python application.
   - Push the Docker image to Docker Hub.
   - Run an Ansible playbook that performs the following tasks on the Vagrant machines:
     - Install Docker.
     - Pull the Docker image from Docker Hub.
     - Run the Docker container from the pulled image.

##

---

## Getting Started:

### 1. **Push Python Code to GitHub**

- Create a private GitHub repository.
- Push the Python application code to the repository using Git.

### 2. **Write a Dockerfile**

- Create a `Dockerfile` for the application with the following steps:

  - Set Python base image `python:3.9-slim`.
  - Set Working Directory `/app`.
  - Copy `requirements.txt` to the current working directory.
  - Install required Python dependencies which are mentioned in `requirements.txt` file. 
  - Copy the application code into the container.
  -  Exposes port 5000 for the application.
  - Set the default command for running the application. 


### 3. **Set Up Vagrant Machines**

- Install Vagrant and VirtualBox.

- Create a `Vagrantfile` to configure two Vagrant machines:

  - Assign minimal CPU and memory to each machine.
  - Set up SSH access for Ansible.

- Example `Vagrantfile`:

  ```ruby
  Vagrant.configure("2") do |config|
    (1..2).each do |i|
      config.vm.define "vm#{i}" do |vm|
        vm.vm.box = "ubuntu/bionic64"
        vm.vm.network "private_network", type: "dhcp"
        vm.vm.provider "virtualbox" do |vb|
          vb.memory = "512"
          vb.cpus = "1"
        end
      end
    end
  end
  ```

- Start the machines using `vagrant up`.

### 4. **Set Up Jenkins Pipeline**

#### Jenkins Steps

1. **Create a Pipeline Job**:

   - Use a pipeline script in Jenkins.
   - Add credentials for GitHub and Docker Hub.

2. **Pipeline Script**:

   - Example pipeline:
     ```groovy
     pipeline {
         agent any

         environment {
             DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
         }

         stages {
             stage('Checkout Code') {
                 steps {
                     git branch: 'main', credentialsId: 'github-token', url: 'https://github.com/your-repo.git'
                 }
             }

             stage('Build Docker Image') {
                 steps {
                     sh 'docker build -t your-dockerhub-username/python-app .'
                 }
             }

             stage('Push to Docker Hub') {
                 steps {
                     sh '''
                     echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin
                     docker push your-dockerhub-username/python-app
                     '''
                 }
             }

             stage('Run Ansible Playbook') {
                 steps {
                     ansiblePlaybook credentialsId: 'ansible-ssh-key', playbook: 'deploy.yml'
                 }
             }
         }
     }
     ```

3. **Run the Pipeline**:

   - Trigger the pipeline and monitor its progress.

### 5. **Ansible Playbook**

- Write an Ansible playbook (`deploy.yml`) to:

  1. Install Docker on the Vagrant machines.
  2. Pull the Docker image from Docker Hub.
  3. Run the Docker container.

- Example playbook:

  ```yaml
  - hosts: all
    become: yes

    tasks:
      - name: Install Docker
        apt:
          name: docker.io
          state: present

      - name: Pull Docker Image
        command: docker pull your-dockerhub-username/python-app

      - name: Run Docker Container
        command: docker run -d --name python-app your-dockerhub-username/python-app
  ```

- Ensure the inventory file points to the Vagrant machines' IP addresses.

---

## Final Notes

- Test each step thoroughly before integrating.
- Use proper logging and error-handling mechanisms in Jenkins and Ansible.
- Ensure secure handling of credentials for GitHub, Docker Hub, and Ansible.

---

Feel free to contribute or raise issues if you encounter any problems!



