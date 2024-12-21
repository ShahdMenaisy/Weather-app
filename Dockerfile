# This Dockerfile is used to build a pyhton application image.
FROM python:3.9-slim

# Setting the working directory to /app
WORKDIR /app

# Copying requirements.txt to the working directory
COPY requirements.txt .

#Installing project dependencies using pip
RUN pip install -r requirements.txt

#Copying the entire project to the working directory
COPY . .

# Making static directory to serve static files (like images or CSS files)
RUN mkdir -p /app/static

# Exposing port 5000 for the application
EXPOSE 5000

# Starting the application when the container runs
CMD ["python", "app.py"]