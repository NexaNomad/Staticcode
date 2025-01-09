# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install Java and necessary tools
RUN apt-get update && \
    apt-get install -y default-jdk wget && \
    rm -rf /var/lib/apt/lists/*

# Install Pylint
RUN pip install --upgrade pip && \
    pip install pylint

# Download Checkstyle
RUN  run: wget -q -O checkstyle.jar https://github.com/checkstyle/checkstyle/releases/download/checkstyle-10.21.1/checkstyle-10.21.1-all.jar

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Define environment variables
ENV CHECKSTYLE_CONFIG=/google_checks.xml

# Run code style checks
CMD pylint sample.py && \
    java -jar checkstyle.jar -c $CHECKSTYLE_CONFIG Sample.java
