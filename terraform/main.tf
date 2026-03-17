terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.regiao_aws
}

resource "aws_s3_bucket" "bucket_desafio_hubii" {
  bucket = var.nome_bucket

  tags = {
    Name        = var.nome_bucket
    Environment = var.ambiente
    Project     = "desafio-hubii"
  }
}