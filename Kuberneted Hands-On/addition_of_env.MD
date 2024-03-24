 # To add environment variables to a Kubernetes Deployment declaratively, you can update the env field in the spec.template.spec.containers section of the Deployment's definition. 


Here's an example of the YAML syntax:
```
spec:
  template:
    spec:
      containers:
      - name: your-container-name
        image: your-image-name:tag
        env:
        - name: ENV_VAR_NAME
          value: env-var-value
```

### Replace "your-container-name" with the actual name of your container, "your-image-name" with the name of your container image, "ENV_VAR_NAME" with the name of the environment variable you want to add, and "env-var-value" with the value of the environment variable. After updating the YAML file, you can apply the changes using the kubectl apply command.

#### This will update the Deployment to include the specified environment variable for the specified container