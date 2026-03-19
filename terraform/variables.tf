variable "aws_region" {
  description = "Região AWS da América do Sul (São Paulo) onde os recursos serão provisionados"
  type        = string
  default     = "sa-east-1"
}

variable "bucket_name" {
  description = "Nome único do bucket S3 que será criado"
  type        = string
  default     = "desafio-hubii-devops-bucket"
}

variable "environment" {
  description = "Ambiente utilizado para identificação e aplicação de tags nos recursos"
  type        = string
  default     = "dev"
}