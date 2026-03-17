output "nome_bucket" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.bucket_desafio_hubii.bucket
}

output "arn_bucket" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.bucket_desafio_hubii.arn
}