output "value" {
  description = "Random secret value"
  value       = random_password.secret.result
}