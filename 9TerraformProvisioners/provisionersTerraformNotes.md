# Terraform Provisioners

## Intro to AWS EC2......

| Instance Type | vCPUs | Memory (GiB) | Purpose                                                     | Cost (per hour, On-Demand) |
|---------------|-------|--------------|-------------------------------------------------------------|----------------------------|
| t4g.nano      | 2     | 0.5          | General purpose - burstable performance with Graviton2 CPUs | $0.0042                    |
| t4g.micro     | 2     | 1            | General purpose - burstable performance with Graviton2 CPUs | $0.0084                    |
| t4g.small     | 2     | 2            | General purpose - burstable performance with Graviton2 CPUs | $0.0168                    |
| t4g.medium    | 2     | 4            | General purpose - burstable performance with Graviton2 CPUs | $0.0336                    |
| t3.nano       | 2     | 0.5          | General purpose - burstable performance                     | $0.0052                    |
| t3.micro      | 2     | 1            | General purpose - burstable performance                     | $0.0104                    |
| t3.small      | 2     | 2            | General purpose - burstable performance                     | $0.0208                    |
| t3.medium     | 2     | 4            | General purpose - burstable performance                     | $0.0416                    |
| m6g.large     | 2     | 8            | General purpose with Graviton2 CPUs                         | $0.0385                    |
| m5.large      | 2     | 8            | General purpose                                             | $0.096                     |
| m5.xlarge     | 4     | 16           | General purpose                                             | $0.192                     |
| c6g.large     | 2     | 4            | Compute optimized with Graviton2 CPUs                       | $0.034                     |
| c5.large      | 2     | 4            | Compute optimized                                           | $0.085                     |
| c5.xlarge     | 4     | 8            | Compute optimized                                           | $0.17                      |
| r6g.large     | 2     | 16           | Memory optimized with Graviton2 CPUs                        | $0.0501                    |
| r5.large      | 2     | 16           | Memory optimized                                            | $0.126                     |
| r5.xlarge     | 4     | 32           | Memory optimized                                            | $0.252                     |
| g4dn.xlarge   | 4     | 16           | GPU optimized - machine learning and graphics workloads     | $0.526                     |
| g4dn.2xlarge  | 8     | 32           | GPU optimized - machine learning and graphics workloads     | $0.752                     |
| g5.xlarge     | 4     | 16           | GPU optimized - graphics-intensive applications             | $1.006                     |
| g5.2xlarge    | 8     | 32           | GPU optimized - graphics-intensive applications             | $2.012                     |
| p3.2xlarge    | 8     | 61           | GPU optimized - deep learning and HPC                       | $3.825                     |
| p3.8xlarge    | 32    | 244          | GPU optimized - deep learning and HPC                       | $15.30                     |
| p4d.24xlarge  | 96    | 1152         | GPU optimized - advanced machine learning and HPC           | $32.77                     |
| i3.large      | 2     | 15.25        | Storage optimized - high IOPS                               | $0.156                     |
| i3.xlarge     | 4     | 30.5         | Storage optimized - high IOPS                               | $0.312                     |

**Note**: The costs listed are approximate On-Demand prices (in USD) as of the writing. AWS pricing can vary by region
and is subject to change. Please verify prices with
the [AWS Pricing Calculator](https://aws.amazon.com/pricing/calculator/).

## AWS EBS Volume Types

| Volume Type              | Name in Terraform   | Use Case                                                                                      | Max IOPS/Volume | Max Throughput/Volume | Durability (Annual Failure Rate) |
|--------------------------|---------------------|-----------------------------------------------------------------------------------------------|-----------------|-----------------------|----------------------------------|
| General Purpose SSD      | `gp3`               | Most workloads, including small-to-medium databases and development environments              | 16,000          | 1,000 MiB/s           | 0.1%-0.2%                        |
| General Purpose SSD      | `gp2`               | Low-latency, high-throughput workloads                                                        | 16,000          | 250 MiB/s             | 0.1%-0.2%                        |
| Provisioned IOPS SSD     | `io2`               | Business-critical apps requiring sustained IOPS, sub-millisecond latency, and high durability | 64,000          | 1,000 MiB/s           | 0.001%                           |
| Provisioned IOPS SSD     | `io2 Block Express` | Large-scale, mission-critical workloads                                                       | 256,000         | 4,000 MiB/s           | 0.001%                           |
| Throughput Optimized HDD | `st1`               | Big data, data warehouses, and log processing                                                 | 500             | 500 MiB/s             | 0.1%-0.2%                        |
| Cold HDD                 | `sc1`               | Infrequently accessed data or archival storage                                                | 250             | 250 MiB/s             | 0.1%-0.2%                        |
| Magnetic                 | `standard`          | Legacy workloads requiring infrequent access                                                  | 40-200          | Up to 90 MiB/s        | 0.1%-0.2%                        |

**Note**: The performance, pricing, and use cases mentioned are as of the writing. Always refer to
the [AWS EBS Pricing and Volume Types](https://aws.amazon.com/ebs/pricing/) for the most accurate and up-to-date
information.

## AWS EC2 with Terraform

```hcl
# main.tf
resource "aws_instance" "webserver" {
  ami           = "ami-123"
  instance_type = "t2.micro"
}

provider "aws" {
  region = "us-west-1"
}

```

### More in depth example - *AI assistant generated*

```hcl

# This full example demonstrates how to set up an AWS instance optimized for GPU workloads using Terraform.
# We use a `g4dn.xlarge` instance, which is ideal for machine learning and graphics workloads.

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "gpu_instance" {
  ami = "ami-12345678" # Replace with a valid AMI ID for a GPU-optimized instance in your region
  instance_type = "g4dn.xlarge"

  # Security group allowing access on port 22 (SSH)
  vpc_security_group_ids = [aws_security_group.gpu_sg.id]

  # Key pair for instance access
  key_name = aws_key_pair.gpu_key.key_name

  tags = {
    Name = "gpu-instance-example"
  }
}

# Security group to allow SSH access
resource "aws_security_group" "gpu_sg" {
  name        = "gpu-security-group-example"
  description = "Allow SSH access"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your specific IP range for better security
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Key pair for SSH access
resource "aws_key_pair" "gpu_key" {
  key_name = "gpu-key-example"
  public_key = file("~/.ssh/id_rsa.pub") # Replace with the path to your public key
}


```

## Terraform Provisioners

```hcl

resource "aws_instance" "webserver" {
  ami           = "ami-123123123"
  instance_type = "t2.micro"
  provisoner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginz",
      "sudo systemctl start nginx"
    ]
  }
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu" # Replace with the appropriate username for your AMI
    private_key = file("~/.ssh/id_rsa") # Replace with the path to your private key
  }
  key_name = aws_key_pair.web.id
  vpc_security_groups_ids = [aws_security_group.ssh-access.id]
}


resource "aws_security_group" "ssh-access" {
  ### code hidden
}


```

### Local exec

```hcl

resource "null_resource" "example" {
  ami = "ami-etc"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    on_failure = continue # default is to fail when issue apply command, overwrite this with on_failure = continue
    command = "echo ${aws_instance.webserver .public_ip} >> /tmp/ips.txt
  }

  provisioner "local-exec" {
    when = destroy
    command = "echo Instance ${aws_instance.webserver .public_ip} Destroyed >> /tmp/instance_state.txt
  }
  
}
```

## Provisioner Behaviour

### Destroy time provisioner
```hcl
  provisioner "local-exec" {
    when = destroy
    command = "echo Instance ${aws_instance.webserver .public_ip} Destroyed >> /tmp/instance_state.txt
  }

```

# Considerations when using provisioners
- Terraform recommends using these sparingly
  - No provisioner information in plan
  - network connectivity and authentication must be run before certain actions