provider "google" {
  credentials = file("/home/sanjuthamke9699/seraphic-being-387204-ae1d8cde5cbb.json")
  project     = "seraphic-being-387204"
  region      = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-2"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "public-subnet"
  ip_cidr_range = "10.1.0.0/24"
  network       = google_compute_network.vpc_network.self_link
  region        = "us-central1"
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_instance" "vm_instance" {
  name         = "testing-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-c"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork         = google_compute_subnetwork.vpc_subnet.self_link
    access_config {
    }

  }

 metadata_startup_script = file("/home/sanjuthamke9699/project/startup_script.sh")
}

