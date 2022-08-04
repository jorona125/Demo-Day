module "webserver" {
  source      = "./modules/webserver" #A
  project_name   = var.project_name #B
  ssh_keypair = var.ssh_keypair #A
  region      = var.region
  vpc       = module.network.vpc #A
  sg        = module.network.sg #A
  db_config = module.database.db_config #A
  subnets   = module.network.subnets
}

module "database" {
  source    = "./modules/database" #A
  project_name = var.project_name #B

    vpc = module.network.vpc #A
  sg  = module.network.sg #A

}

module "network" {
  source    = "./modules/network" #A
  project_name = var.project_name #B
}
