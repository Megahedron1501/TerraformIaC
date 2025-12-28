# WordPress Terraform Project

Complete WordPress + MySQL + phpMyAdmin stack deployed with Infrastructure as Code.

## Quick Start
\\\ash
terraform init
terraform apply
\\\

## Access
- **WordPress:** http://localhost:8081
- **phpMyAdmin:** http://localhost:8082 (login: wordpress/wordpresspassword)

## Architecture
- WordPress container (port 8081)
- MySQL container (database)
- phpMyAdmin container (port 8082)
- Private Docker network

## Files
- \main.tf\ - Terraform configuration
- \.gitignore\ - Excluded files
