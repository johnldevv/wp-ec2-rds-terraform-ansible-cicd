# WordPress on EC2 + RDS with Terraform, Ansible, and CI/CD

This project automates the deployment of a production-ready WordPress environment on AWS using:

- **Terraform** for infrastructure provisioning (EC2, RDS, Security Groups)
- **Ansible** for server configuration (Nginx, PHP-FPM, WordPress)
- **GitHub Actions** for CI/CD (optional integration)
- **Shell script (`deploy.sh`)** for end-to-end deployment

---

## 🔧 What It Does

- Provisions an EC2 instance (Ubuntu 20.04) and RDS MySQL database
- Installs and configures Nginx, PHP, and WordPress
- Ensures Apache is fully removed to prevent Nginx conflicts
- Sets up WordPress in `/var/www/html/wordpress`
- Configures Nginx as the primary web server
- Uses `terraform output` and dynamic Ansible inventory to connect

---

## 📁 Project Structure

```bash
.
├── infra/           # Terraform files (main.tf, variables.tf, outputs.tf)
├── ansible/         # Ansible playbook and tasks
│   └── site.yml     # Installs and configures Nginx + WordPress
├── deploy.sh        # End-to-end deployment script
└── README.md
