# To create a Dockerfile for a Node.js application, you can use the following example :

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
## Expose the port the app runs on
```
EXPOSE 3000
```
## Define the command to run your app using CMD
```
CMD [ "node", "app.js" ]
```

#### In this example, the Dockerfile sets up a Node.js environment, installs the application dependencies, copies the application code, exposes the port, and defines the command to start the application. This Dockerfile assumes that your Node.js application's entry point is app.js and that it listens on port 3000.