# Project: AWS Infrastructure with Terraform

This project demonstrates how to create an AWS infrastructure using Terraform. The infrastructure includes a VPC, EC2 instance, security groups, and NAT rule.

## Prerequisites

- Terraform installed on your local machine
- AWS CLI configured with appropriate credentials
- An AWS account

## Infrastructure Components

1. **VPC**: A Virtual Private Cloud to host your AWS resources.
2. **EC2 Instance**: A virtual server to run your applications.
3. **Security Groups**: Firewall rules to control inbound and outbound traffic.
4. **NAT Rule**: Network Address Translation to allow instances in a private subnet to access the internet.

## Setup Instructions

1. **Clone the Repository**
    ```sh
    git clone <repository-url>
    cd <repository-directory>
    ```

2. **Initialize Terraform**
    ```sh
    terraform init
    ```

3. **Plan the Infrastructure**
    ```sh
    terraform plan
    ```

4. **Apply the Configuration**
    ```sh
    terraform apply
    ```

5. **Destroy the Infrastructure (if needed)**
    ```sh
    terraform destroy
    ```

## File Structure

- `main.tf`: Main Terraform configuration file.
- `variables.tf`: Variables used in the Terraform configuration.
- `outputs.tf`: Outputs of the Terraform configuration.

## Author

- [Your Name](https://github.com/your-github-profile)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Terraform Documentation
- AWS Documentation
