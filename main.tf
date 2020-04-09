provider "google" {
  credentials = var.gcp_json_credentials
  project     = var.project_id
  region      = "us-central1"
}

module "network" {
  source  = "app.terraform.io/aharness-org/network/google"
  version = "2.2.0"
}
  
  network_name = var.network_name
  project_id = var.project_id
  subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-central1"
        }
}
