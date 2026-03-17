variable "regiao_aws" {
  description = "Região AWS onde o bucket S3 sera provisionado"
  type        = string
  default     = "sa-east-1"
}

variable "nome_bucket" {
  description = "Nome do bucket"
  type        = string
  default     = "desafio-hubii-devops-bucket"
}

variable "ambiente" {
  description = "Ambiente utilizado para identificação e tags"
  type        = string
  default     = "dev"
}