Step 1: Ensure Docker and Docker Compose are Installed
Check Docker Installation:

Run docker --version to check if Docker is installed.
If not installed, follow the Docker installation guide for your operating system.
Check Docker Compose Installation:

Run docker-compose --version to check if Docker Compose is installed.
If not installed, follow the Docker Compose installation guide for your operating system.



Step 2: Clone the Git Repository
Clone the Repository:

Navigate to the directory where you want to clone the project.
Use the following command to clone the repository (replace your-repo-url with the actual repository URL):

git clone https://github.com/zicttraining/DevOps-cloud-training-.git

cd DevOps-cloud-training-/Docker Hands-On/Monitoring$

Review the Project Structure:

Ensure that the project directory contains the necessary files like docker-compose.yml, prometheus.yml, nginx.conf, and any other required files such as the html directory for serving content.

Step 3: Create Configuration Files (If Needed)
Check for Missing Configurations:
If the repository doesn't include necessary configuration files (e.g., prometheus.yml, nginx.conf), create them within the cloned directory.
Step 4: Bring Up the Services
Start Docker Services:
In the terminal, navigate to the cloned project directory if you're not already there:

Use Docker Compose to start all services

sudo docker-compose up -d



The -d flag runs the services in detached mode (in the background).
Step 5: Verify the Containers
Check the Status of Containers:

Run the following command to see the status of the running containers:
Step 6: Verify the Containers
Check the status of the containers:

View Logs:

sudo docker-compose logs -f


Step 6: Test the Application
Access Prometheus:

Open your web browser and navigate to http://localhost:9090 to access Prometheus.
Verify that Prometheus is scraping the correct metrics.
Access Grafana:

Open your web browser and navigate to http://localhost:3000 to access Grafana.
Log in using admin/admin (or any other credentials set in the environment variables).
Configure data sources and dashboards as needed.
Access Nginx:

Open your web browser and navigate to http://localhost:80 to test the Nginx web server.
Ensure that the content in the html directory is being served correctly.
Test Nginx Exporter:

Open your web browser and navigate to http://localhost:9113/metrics to ensure the Nginx Prometheus Exporter is functioning.

To destroy
sudo docker compose down 