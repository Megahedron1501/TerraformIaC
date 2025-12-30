# WordPress Terraform Project

Complete WordPress + MySQL + phpMyAdmin stack deployed with Infrastructure as Code.

## Features
- Docker containers for all services
- MySQL 8.0 database with persistent storage
- WordPress with automatic database configuration
- phpMyAdmin for database management
- Secure password management with Terraform variables
- Private Docker network for container communication

## Quick Start

1. **Clone this repository**
    \`\`\`bash
    git clone https://github.com/Megahedron1501/TerraformIaC.git
    cd TerraformIaC
    \`\`\`

2. **Set up passwords** (create \`terraform.tfvars\`):
    \`\`\`hcl
    mysql_root_password = "your_secure_root_password"
    mysql_password = "your_secure_wp_user_password"
    \`\`\`

3. **Initialize and deploy** 
    \`\`\`bash
    terraform init
    terraform apply
    \`\`\`

## Access
- **WordPress:** http://localhost:8081 (setup page)
- **phpMyAdmin:** http://localhost:8082
    - Server: \`mysql_db\`
    - Username: \`wordpress\`
    - Password: Use the \`mysql_password\` from your \`terraform.tfvars\` file

## Architecture
- **WordPress container** (port 8081)
- **MySQL container** (database with persistent storage)
- **phpMyAdmin container** (port 8082, database management)
- **Private Docker bridge network** for secure communication

## Security Notes
- Passwords are stored in \`terraform.tfvars\` (local file, NOT in Git)
- The \`.gitignore\` file protects all sensitive files
- Never commit \`terraform.tfvars\` or \`*.tfstate\` files

## Files
- \`main.tf\` - Terraform configuration (uses variables for passwords)
- \`variables.tf\` - Variable definitions
- \`.gitignore\` - Protects sensitive files from Git
- \`.terraform.lock.hcl\` - Terraform dependency lock
- \`terraform.tfvars\` - YOUR passwords (create this locally)

## Troubleshooting
- **Port conflicts?** Edit port numbers in \`variables.tf\`
- **Containers not starting?** Check with \`docker ps\`
- **Terraform errors?** Run \`terraform validate\`

## Requirements
- [Docker Desktop](https://docker.com/products/docker-desktop/)
- [Terraform](https://www.terraform.io/downloads.html)
- Git 
