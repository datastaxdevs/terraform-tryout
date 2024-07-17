module "datastax-ai-stack-aws" {
   source = "./aws"

   domain_config = {
     auto_route53_setup = true
     hosted_zones = {
       default = { zone_name = "enterprise-ai-stack.com" }
     }
   }

   langflow = {
     domain = "langflow.enterprise-ai-stack.com"
   }

   assistants = {
     domain = "assistants.enterprise-ai-stack.com"
     db = {
       deletion_protection = false
     }
   }

   vector_dbs = [{
     name      = "terraform_demo"
     keyspaces = ["default_keyspace"]
   }]
 }