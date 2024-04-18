# Folder aws-eks-cluster with manifest files for cluster creation
  - eksctl create cluster -f development-env-cluster.yaml
  - eksctl create cluster -f production-env-cluster.yaml
  - eksctl delete cluster -f development-env-cluster.yaml
  - eksctl delete cluster -f production-env-cluster.yaml

# Folder argocd_deploy with terraform file for ArgoCD Deploying
  - terraform init
  - terraform apply

# Or using module like this

module "argocd_prod" {
  source           = "./argocd_deploy"
  eks_cluster_name = "production-env"
  chart_version    = "5.46.2"
}

# Folder argocd_root_app_deploy with terraform file for root application deployment
settings for argocd before apply:
 - kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d  to get a password
 - kubectl port-forward service/argocd-server -n argocd 8080:443 expose argo on 8080 port
 - ssh-keygen to generate private and public keys. Add private in Argo and public to GIT for repo connection
# How to use a module for root application
Can be deployed ONLY after ArgoCD deployment: depends_on = [module.argocd_dev]
module "argocd_dev_root" {
   source             = "./argocd_root_app_deploy"
   eks_cluster_name   = "development-env"
   git_source_path    = "development-env/applications"
   git_source_repoURL = "git@github.com:chak1988/argocd.git"
 } 