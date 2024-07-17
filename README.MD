
## Terraform Providers for RagStack AI

## Table of content

1. [Overview](#1-overview)
2. [Installation and Prerequisites](#2-installation-and-prerequisites)
3. [AWS Deployments]()
4. [GCP Deployments]()
5. [Azure Deployments]()

## 1. Overview

Terraform module which helps you quickly deploy an opinionated AI/RAG stack to AWS, provided by Datastax.

## 2. Installation and Prerequisites

### 2.1 - Terraform Installation

> Note: Check [Terraform Documentation](https://developer.hashicorp.com/terraform/install)


- ✅ `2.1.a` **Update Homebrew**: Before installing any new package, it's good practice to update Homebrew:

```sh
brew update
```

- ✅ `2.1.b` **Install Terraform**: To install Terraform using Homebrew, run the following command:

```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

- ✅ `2.1.c` **Verification**; After the installation completes, verify that Terraform is installed correctly by checking its version:

```sh
terraform -v
```

### 2.2 - Astra CLI Installation

Astra CLI is a command-line interface (CLI) tool that enables users to interact with and manage the 
Astra database-as-a-service platform. It provides developers with a streamlined way to create, configure, and 
manipulate databases, making it easier to integrate Astra into their applications and workflows.

Astra CLI goes beyond basic database management by facilitating the seamless integration of external tools like **dsbulk**, 
**cqlsh**, and **pulshar-shell** or by providing useful shortcuts like **dotenv** file generation.

- ✅ `2.2.a` **Update Homebrew**: Before installing any new package, it's good practice to update Homebrew:

```sh
brew update
```

- ✅ `2.2.b` **Install Astra CLI**: To install Terraform using Homebrew, run the following command:

```sh
brew install datastax/astra-cli/astra-cli
```

- ✅ `2.2.c` Connect to [https://astra.datastax.com](https://astra.datastax.com)

![imgs/01-login.png](imgs/01-login.png)

- ✅ `2.2.d` Navigate to token and generate a token with `Organization Administrator` permissions and copy the token starting by `AstraCS:...`

![imgs/02-token.png](imgs/02-token.png)

> Note:
>
> `osx` is based on a linux kernel and can run shell scripts. Files are
> installed in `/usr/local/Cellar/astra-cli/<version>` and linked with a 
> symbolic link to `/usr/local/bin/astra`. The configuration of the CLI is 
> stored in `~/.astrarc` - **It is not lost on updates

- ✅ `2.2.e` Issue `setup` command and provide your token as an input. It must start by `AstraCS:...`. Make sure to have the `Organization Administrator` role to avoid any permission limitations later on.

```sh
astra setup --token AstraCS...
```

- ✅ `2.2.f`Display your local configuration list, validating setup is complete. 

```bash
astra config list
```

- ✅ `2.2.g`Create a `vector database` with the CLI

```bash
astra db create terraform_demo --vector --async
```

- ✅ You can see it pending with 

```bash
astra db list
```

```console
+---------------------+--------------------------------------+-----------+-------+---+-----------+
| Name                | id                                   | Regions   | Cloud | V | Status    |
+---------------------+--------------------------------------+-----------+-------+---+-----------+
| terraform_demo      | 2753308c-34bc-4bff-ab87-0ff3f2218fa3 | us-east1  | gcp   | ■ | PENDING   |
+---------------------+--------------------------------------+-----------+-------+---+-----------+
```

### 2.d Get the sample project

```
git clone git@github.com:datastax/terraform-datastax-ai-stack.git
```

## 3. AWS Deployment

![imgs/aws-03.png](imgs/aws-03.png)

### 3.a AWS Credentials

- ✅ Access the Idenity and Access Management console (IAM) in AWS

- ✅ Create a an User with AWS and add the different permissions. 

- ✅ For this user create a pair of keys wih `access_key` and `secret_key` as follows:

![imgs/aws-01.png](imgs/aws-01.png)

- Setup the access for an application outside

![imgs/aws-02.png](imgs/aws-02.png)


### 3.b Change `providers.tf`

- ✅ Access proper folder

```
de terraform-datastax.ai-stack
cd demo
```

- ✅ Update `providers.tf` as follows

```typesafe
provider "astra" {
  token = "YOUR_TOKEN"
}

provider "aws" {
  region     = "us-west-2"
  access_key = "KEY"
  secret_key = "SECRET"
  #profile = var.aws_profile
}
```

- ✅ Update `terraform.tf` as follows (filtering only AWS)

```typesafe
terraform {
  required_providers {
    astra = {
      source  = "datastax/astra"
      version = "~> 2.3.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }
  }
}
```

- ✅ Update `output.tf` as follows (selecting AWS)

```console
output "datastax-ai-stack-aws" {
   value     = module.datastax-ai-stack-aws
   sensitive = true
}
```

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```

## 4. GCP Deployment

## 5. AZURE Deployment

