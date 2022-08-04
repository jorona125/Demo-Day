output "vpc" {
  value = module.vpc #A
}

output "sg" {
  value = { #B
    lb     = module.lb_sg.security_group.id #B
    db     = module.db_sg.security_group.id #B
    websvr = module.websvr_sg.security_group.id #B
  } #B
}


output "subnets" {
  value = {
   one =  module.vpc.public_subnets[0]
   two =  module.vpc.public_subnets[1]
   three = module.vpc.public_subnets[2]  
  } 
}