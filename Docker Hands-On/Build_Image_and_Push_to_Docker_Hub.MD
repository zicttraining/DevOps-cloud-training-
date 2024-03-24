### To create a Docker image for a Node.js application and push it to Docker Hub, follow these steps :

1. Create a Dockerfile with the following content:

## Use an official Node.js runtime as a parent image
```
FROM node:14
```
## Set the working directory in the container
```
WORKDIR /usr/src/app
```
## Copy package.json and package-lock.json to the working directory
```
COPY package*.json ./
```
## Install app dependencies
```
RUN npm install
```
## Bundle app source
```
COPY . .
```
# Expose the port the app runs on
```
EXPOSE 3000
```
## Define the command to run your app using CMD
```
CMD ["npm", "start"]
```

2. Build the Docker image:
```
docker build -t my-node-app .
```
3. Log in to Docker Hub:
```
docker login --username YOUR_USERNAME
```

4. Replace YOUR_USERNAME with your Docker Hub username.


5. Tag the image with your Docker Hub username:
```
docker tag my-node-app YOUR_USERNAME/my-node-app
```

6. Push the image to Docker Hub:
```
docker push YOUR_USERNAME/my-node-app
```
