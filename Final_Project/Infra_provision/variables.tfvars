
vpc_cidr_block = "10.10.0.0/20"

environment = "devops"
max_subnet_count = 2
to_port = 65535
from_port = 0 

#EKS master variables
eks_cluster_policy_names = ["AmazonEKSClusterPolicy", "AmazonEKSVPCResourceController"]
eks_master_plane_version = "1.28"


#EKS node group variables
instance_types = "t2.micro"
disk_size = 30
desired_size = 1
min_size = 1
max_size = 2
k8s_version = "1.28"
eks_nodegroup_policy_names = ["AmazonEKSWorkerNodePolicy", "AmazonEKS_CNI_Policy", "AmazonEC2ContainerRegistryReadOnly"]

ecr_repositories = ["my-repositories"]


