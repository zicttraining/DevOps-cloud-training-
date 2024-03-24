# Node.js Hello World Application

This is a simple Node.js application that prints "Hello, World!" to the browser.

## Prerequisites

Before running this application, ensure that you have the following installed on your system:

- Node.js: [Download and Install Node.js](https://nodejs.org/)
- Docker: [Download and Install Docker](https://www.docker.com/)

## Setup & Configuration

1. Clone this repository to your local machine:

    ```bash
    git clone <repository_url>
    ```

2. Navigate to the project directory:

    ```bash
    cd <project_directory>
    ```

## Building Application Image

To build the Docker image for the application, run the following command:

```bash
docker build -t node-hello-world .
```

## Creating Container
To create and run a container using the built image, use the following command:

```bash
docker run -d -p 3000:3000 --name hello-world-app node-hello-world
```

This command will start the container in detached mode (-d), map port 3000 on the host to port 3000 in the container (-p), and name the container as "hello-world-app" (--name).

## Accessing Application
Once the container is running, you can access the application by opening a web browser and navigating to **http://localhost:3000.** You should see the message "Hello, World!" displayed on the page.

## Cleanup

To stop and remove the running container, use the following commands:

```bash
docker stop hello-world-app
docker rm hello-world-app
```


