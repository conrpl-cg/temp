terraform {
  required_providers {
    okta = {
        source = "okta/okta"
    }
    /*cgokta = {
      source = "localterraform.com/okta/cgokta"
      version = "1.0.0"
    }*/
  }
  /*cloud {
    hostname     = "tfe.cguser.capgroup.com"
    organization = "msd-dev"
    workspaces {
      name = "dip-okta-cac-workspace"
    }
  }*/
}

provider "okta" {
  org_name = var.org_name
  base_url = var.base_url
  api_token = var.api_token
}

/*provider "cgokta" {
  org_name = var.org_name
  base_url = var.base_url
  api_token = var.api_token
}*/

variable "vision_cert" {
  default=""
}

variable "domain_cert" {
  default=""
}

variable "target_env_name" {
  default="dev"
}

variable "org_name" {
  default="demo-terraform-cg"
}

variable "base_url" {
  default="okta.com"
}

variable "api_token" {
  default="00HpXCILPlk6GMA6Zx3Dza6cBx186Pm_GKPtnFit7r"
}
