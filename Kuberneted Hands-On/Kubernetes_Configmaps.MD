# To create a ConfigMap in Kubernetes using the declarative method, you can use a YAML file. 

Here's an example of creating a ConfigMap named my-configmap from a file:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
data:
  config1: value1
  config2: value2
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap-from-dir
data:
  config3: |-
    file-content-from-directory
  config4: |-
    another-file-content-from-directory
  # Specify the directory path
  config5: |-
    $(cat path/to/directory/config-file)
  # Use `$(cat ...)` to read the content of a file in the directory
spec:
  # Specify the directory path
  # Only files with basenames that are valid keys are included
  # Subdirectories and non-regular files are not included in the ConfigMap
  # If you want to include all files, use `--from-file` option with `--recursive`
  # (available in kubectl version 1.19+)
  # or use ConfigMapGenerator in kustomization.yaml
  # (available in kubectl version 1.18+)
  # For example:
  # kubectl create configmap my-configmap-from-dir --from-file=path/to/directory --re To create the ConfigMap, save the YAML file as `my-configmap.yaml` and apply it using `kubectl apply`:
```

```bash
kubectl apply -f my-configmap.yaml
```

#### If you want to create a ConfigMap from a directory, you can use the --from-file option with --recursive (available in kubectl version 1.19+) or use ConfigMapGenerator in kustomization.yaml (available in kubectl version 1.18+).




