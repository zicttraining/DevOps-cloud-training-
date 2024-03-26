# To modify the container image in a Kubernetes Deployment declaratively, you can update the image field in the spec.template.spec.containers section of the Deployment's definition. 

Here's an example of the YAML syntax:
```
spec:
  template:
    spec:
      containers:
      - name: your-container-name
        image: your-new-image:tag
```

### Replace "your-container-name" with the actual name of your container, "your-new-image" with the new image name, and "tag" with the image tag. After updating the YAML file, you can apply the changes using the kubectl apply command

#### This will update the Deployment to use the new container image for the specified container