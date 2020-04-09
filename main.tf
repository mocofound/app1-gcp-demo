provider "google" {
  credentials = var.gcp_json_credentials
  project     = var.project_id
  region      = "us-central1"
}

module "network" {
  source  = "app.terraform.io/aharness-org/network/google"
  version = "2.2.0"
  
  #Required Variables
  network_name = var.network_name
  project_id = var.project_id
  subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-central1"
        },]
}
  
  
resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  #tags = ["foo", "bar"]
  tags = {
    name = "app1"
    ttl = "6000"
    owner = "devops@test.com"
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    subnetwork = "subnet-01"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

  

