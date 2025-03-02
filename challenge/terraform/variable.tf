variable "replica_count" {
  default = 2
}

variable "image" {
  default = "docker.io/richie001/crewmeister-challenge:latest"
}

variable "environment" {
  default = "local"
}
