**Objective**

Run an Nginx container that serves content on localhost, and use a separate curl container to make HTTP requests to it. This exercise will demonstrate inter-container communication on the same Docker network.

**Setup Overview**

Start an Nginx container that serves content on localhost.
Use curl inside a separate container to request content from the Nginx container through localhost.

**Steps**

**Step 1: Run the Nginx Container** 

Run an Nginx container attached to the my_network network. This container will act as a web server.


```docker run -d --name my-nginx --network my_network -p 8080:80 nginx```

``-d:`` Run the container in detached mode.

``--name my-nginx:`` Names the container my-nginx for easy reference.

``--network my_network: `` Connects the container to my_network.

``-p 8080:80:`` Maps port 80 in the container to port 8080 on localhost.

Now, Nginx is running and serving content on localhost:8080.

Verify Nginx is Running
To check if Nginx is working, you can run the following command:


``curl localhost:8080``

If successful, this will return the default Nginx welcome page.

Step 3: Use a Separate Container with curl to Access Nginx
Now, let’s use a separate container running curl to request content from the Nginx container.

Run a curl container attached to the same my_network network.


``--rm:`` Automatically remove the container after it exits.
--network my_network: Ensures the curl container can communicate with my-nginx.
curlimages/curl:latest: Uses the official curl image from Docker Hub.
http://my-nginx: Accesses the Nginx container by its name (my-nginx), as both containers are on the same network.
The command will return the HTML content served by the Nginx container.

Step 4: Verify Access Through localhost on the Host Machine
Run curl from your host machine to access the Nginx container via localhost:8080.


``curl http://localhost:8080``

This will also return the default Nginx welcome page, verifying that Nginx is accessible from localhost on the host machine.

Explanation of What Happened
Docker Network: Both the Nginx and curl containers were attached to a custom network (my_network), which allowed the curl container to resolve and access my-nginx by name.
Inter-Container Communication: By connecting both containers to the same Docker network, Docker’s internal DNS resolves the my-nginx hostname to its container IP, enabling seamless communication.
Access via localhost: The -p 8080:80 flag mapped Nginx’s port 80 to port 8080 on localhost, allowing access from the host machine.
Clean Up
To stop and remove the Nginx container, and delete the custom network:

```
docker stop my-nginx
docker rm my-nginx
```

**Summary**

In this exercise, you:

Deployed an Nginx server in a Docker container.
Created a custom network for container communication.
Used a separate container to make an HTTP request to Nginx via localhost using curl.
Verified that the Nginx container is accessible both internally (from other containers) and externally (from the host machine).
This exercise highlights how Docker networking enables communication between containers and between containers and the host machine.