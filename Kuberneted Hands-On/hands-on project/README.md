- **python-flask**: Directory containing the Python Flask application.
  - **src**: Directory containing the source code of the Flask application.
    - **app.py**: Python Flask application code.
  - **Dockerfile**: Dockerfile for building the Flask application image.
  - **requirements.txt**: List of Python dependencies for the Flask application.

## Instructions

Follow these steps to build, containerize, and deploy the Python Flask application:

1. **Build Docker Image**: Navigate to the `python-flask` directory and run the following command to build the Docker image:
    ```
    docker build -t app .
    ```

2. **Push Docker Image**: Push the built Docker image to your preferred container registry (e.g., AWS ECR, Docker Hub):
    ```
    docker tag app:latest <your-container-registry>/<repository-name>:<tag>
    docker push <your-container-registry>/<repository-name>:<tag>
    ```

3. **Deploy to Kubernetes**: Use Helm to deploy the application to Kubernetes. Ensure you have Helm installed and configured properly. Navigate to the `k8s/charts` directory and run the following command:
    ```
    helm install app-helmchart ./manifest_files
    ```

4. **Accessing the Application**: Once deployed, you can access the Flask application using the Ingress endpoint or NodePort depending on your Kubernetes setup.

## Notes

- Modify the `app.py` file in the `src` directory to customize the Flask application according to your requirements.
- Adjust the Dockerfile and Helm chart as needed based on your application's dependencies and configurations.