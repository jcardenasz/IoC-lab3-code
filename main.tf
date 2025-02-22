terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "~> 6.0"
    }
  }
}

variable "GITHUB_TOKEN" {
  description = "Github token access"
  type = string
}

provider "github" {
  token = var.GITHUB_TOKEN
}

resource "github_repository" "Repo" {
  name = "Iac - lab3 repo"
  description = "Este repositorio es una prueba de terraform para el laboratorio 3 de Infra & Arch."
  visibility = "public"

  template {
    owner = "getindata"
    repository = "terraform-module-template"
    include_all_branches = true
  }

  pages {
    build_type = "workflow"
    source {
      branch = "main"
      path = "/docs"
    }
  }


}

resource "github_branch" "Master" {
  repository = github_repository.Repo.name
  branch     = "master"
}

resource "github_branch" "Dev" {
  repository = github_repository.Repo.name
  branch = "dev"
}

resource "github_branch" "Pagos" {
  repository = github_repository.Repo.name
  branch = "payment"
}