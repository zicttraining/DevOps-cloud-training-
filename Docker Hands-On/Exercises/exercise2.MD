Here's a guide to creating a custom Dockerfile for Nginx, adding a configuration file, and serving a custom HTML page with styling.

**1. Directory Structure**

Start by creating a folder structure for the project:

`` mkdir my-nginx

  cd my-nginx
``

``
my-nginx/
├── Dockerfile
├── nginx.conf
└── html/
    └── index.html
``    


**2. Dockerfile**

Create a Dockerfile in the my-nginx/ directory. This Dockerfile will copy your custom Nginx configuration and HTML files into the container.

``code  Dockerfile``

Dockerfile
copy and paste this code in the Dockerfile
```
# Start from the official Nginx base image
FROM nginx:latest

# Copy custom Nginx configuration file to the Nginx configuration directory
COPY nginx.conf /etc/nginx/nginx.conf

# Copy HTML content to the default Nginx HTML directory
COPY html/ /usr/share/nginx/html/

# Expose port 80 to access the web server
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
3. Nginx Configuration File (nginx.conf)

```
Create an nginx.conf file to specify custom configurations for Nginx.

```
nginx

# nginx.conf

worker_processes 1;

events {
    worker_connections 1024;
}

http {
    server {
        listen 80;
        
        # Location of the HTML files
        location / {
            root /usr/share/nginx/html;
            index index.html;
        }
    }
}

```


**4. HTML File (index.html)**

Create an index.html file in the html/ folder. This file will display a welcome message with CSS styling.

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vincent's Server</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f5;
        }
        .container {
            text-align: center;
            padding: 20px;
            border: 2px solid #4caf50;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }
        h1 {
            color: #4caf50;
        }
        p {
            color: #333333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Hello!</h1>
        <p>This server is being run from Vincent's container with Docker.</p>
    </div>
</body>
</html>

```

In this HTML file:

The <style> block adds basic styling, including centering the content, background colors, and shadow effects.
The message "This server is being run from Vincent's container with Docker" is displayed in a styled box.

**5. Build and Run the Docker Container**

In your terminal, navigate to the my-nginx/ directory and build the Docker image.

```
docker build -t vincent-nginx .
```

Run the Docker container:


``sudo docker run -d -p 8080:80 --name vincent-nginx-container vincent-nginx``

Now, open your browser and navigate to http://localhost:8080. You should see the custom-styled message: "Hello! This server is being run from Vincent's container with Docker."

Explanation
``Dockerfile:`` Sets up Nginx with custom configuration and HTML files.

``nginx.conf:`` Configures Nginx to serve files from the /usr/share/nginx/html directory.

``index.html:`` Displays a custom message with CSS styling.

This setup provides a customized Nginx server running in a Docker container with a styled HTML message.



To push the Docker image to Docker Hub, you'll need to follow these steps:

Login to Docker Hub (if not already logged in).
Tag the image with your Docker Hub username.
Push the image to Docker Hub.
Here’s a detailed guide to accomplish this:

**Step 5: Login to Docker Hub**

If you haven’t logged into Docker Hub yet, use the following command:


**docker login -u **

You’ll be prompted to enter your Docker Hub username and password.

**Step 2: Tag the Image**
To push the image to Docker Hub, you need to tag it with your Docker Hub repository name. The tag format should be username/repository:tag.

For example, if your Docker Hub username is vincent, tag the image as follows:


``sudo docker tag vincent-nginx vincent/vincent-nginx:latest``

Here:

vincent-nginx is the local image name.
vincent/vincent-nginx:latest is the tagged name that includes your Docker Hub username.

**Step 3: Push the Image to Docker Hub**

Now, push the tagged image to Docker Hub:


``sudo docker push vincent/vincent-nginx:latest``
This will upload the image to your Docker Hub repository vincent/vincent-nginx.

**Step 4: Verify the Image on Docker Hub**

After the push completes, you can verify it by logging into your Docker Hub account and checking the repository.


Now, your image vincent/vincent-nginx:latest should be publicly available on Docker Hub, and you (or anyone else) can pull it using:

``sudo docker pull vincent/vincent-nginx:latest``

Replace vincent with your Docker Hub username as needed.