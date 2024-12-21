Task: Build and deploy a simple web application on target machines using a CI pipeline. 
This repository contains a complete setup for automating the deployment of a Python application using Jenkins, Docker, Vagrant, and Ansible. The project involves the following steps:
1. Push Python Code to GitHub

2. Write a Dockerfile to containerize the Python application and push it to your repository.

3. Set Up 2 Vagrant Machines

4. Implement Jenkins Pipeline to:
          Pull code from the GitHub repository
          Build a Docker image for the Python application.
          Push the Docker image to Docker Hub.
          Run an Ansible playbook that performs the following tasks on the Vagrant machines:
                  Install Docker.
                  Pull the Docker image from Docker Hub.
                  Run the Docker container from the pulled image.


