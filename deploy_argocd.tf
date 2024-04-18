# module "argocd_dev" {
#   source           = "./argocd_deploy"
#   eks_cluster_name = "development-env"
#   chart_version    = "5.46.7"
# }


module "argocd_prod" {
  source           = "./argocd_deploy"
  eks_cluster_name = "production-env"
  chart_version    = "5.46.2"
}


# Can be deployed ONLY after ArgoCD deployment: depends_on = [module.argocd_dev]
# module "argocd_dev_root" {
#   source             = "./argocd_root_app_deploy"
#   eks_cluster_name   = "development-env"
#   git_source_path    = "development-env/applications"
#   git_source_repoURL = "git@github.com:chak1988/argocd.git"
# }

# Can be deployed ONLY after ArgoCD deployment: depends_on = [module.argocd_prod]
# module "argocd_prod_root" {
#   source             = "./argocd_root_app_deploy"
#   eks_cluster_name   = "production-env"
#   git_source_path    = "production-env/applications"
#   git_source_repoURL = "git@github.com:chak1988/argocd.git"
# }
