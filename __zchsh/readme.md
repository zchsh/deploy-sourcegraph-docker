# Learning Terraform, trying to set up SourceGraph

## Overview

- Aim: trying to learn Terraform a bit
- Thinking about how to replicate the instructions SourceGraph gives for AWS config
- For fun, also to try to learn Terraform, also because I don't enjoy clicking around the AWS UI

## How to use these files to deploy a SourceGraph instance to AWS

- [Install](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and [configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config) the AWS CLI (version 2).
- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
- `cd` into this directory, then `cd` into `terraform`
- Run `terraform apply`

## Background

- Trying to set up SourceGraph
- SourceGraph has many [install options](https://docs.sourcegraph.com/admin/install)
- The [Docker Compose install option](https://docs.sourcegraph.com/admin/install/docker-compose) seemed appropriate for our use case
- I already have a personal AWS account, so I thought I'd try the [Docker Compose on AWS option](https://docs.sourcegraph.com/admin/install/docker-compose/aws)

## Part 1 - SourceGraph - Storing Customizations In a Fork

- Followed [SourceGraph's instructions on storing customizations in a fork](https://docs.sourcegraph.com/admin/install/docker-compose#optional-recommended-store-customizations-in-a-fork)
- Created this repo, and created a `release` branch based on upstream `v3.23.0` tag

## Part 2 - AWS CLI - Getting set up

Realized, [thanks to a Learn pre-requisites list](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#prerequisites), I needed some way to authenticate to AWS in order for `terraform` to be able to do anything.

- [Installed the AWS CLI (version 2)](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Configured the AWS CLI with my root credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config)
  - This should probably be done in a less priviledged way, I think?
  - For now I'm just playing around, so I didn't worry about it

## Part 3 - Terraform - Getting Familiar

- [Installed `terraform`](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) - I used the `homebrew` option
  - I also tried out the [`"Quick Start Tutorial"`](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#quick-start-tutorial) at the bottom of the install guide, since I already had [`Docker Desktop`](https://docs.docker.com/docker-for-mac/install/) installed
- Worked through the `build` and `destroy` parts of the [AWS Getting Started Tutorial](https://learn.hashicorp.com/collections/terraform/aws-get-started)

## Part 4 - Terraform - Trying to do what I want

Generally, I'm trying to replicate the instructions SourceGraph gives for AWS config.

- I tried some basic tutorials (including the [AWS Getting Started Tutorial on Learn](https://learn.hashicorp.com/collections/terraform/aws-get-started)
  - ... but found I couldn't connect to the EC2 instance as expected.
- So, I followed [a random tutorial](https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f)
  - ...and now I can connect
  - I have a vague understanding of some of the `.tf` files
  - But still feel like I mostly have no idea why things weren't working before...
  - ...and no idea why they are working now

## Figuring out `aws_instance` settings for Terraform

- `ami_id`
  - The Learn guide had a [helpful troubleshooting section](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#troubleshooting)
  - I followed the link to AWS' [Finding a Quick Start AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html#finding-quick-start-ami) page
  - SourceGraph specifies that [a Amazon Linux 2 AMI](https://docs.sourcegraph.com/admin/install/docker-compose/aws#deploy-to-ec2) should be used
  - This was the first command on AWS' Quick Start page:

      ```s
      aws ec2 describe-images \
        --owners amazon \
        --filters "Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2" "Name=state,Values=available" \
        --query "reverse(sort_by(Images, &CreationDate))[:1].ImageId" \
        --output text
      ```

  - This gave me the ID `"ami-0a0ad6b70e61be944"` (for my default `us-east-2` region, which I set in the AWS CLI)

- `instance_type`
  - I used [SourceGraph's resource estimator](https://docs.sourcegraph.com/admin/install/resource_estimator)
  - I input `50` repos, and `20` users, with `0` large monorepos, at `50%` engagement
  - I selected the `docker_compose` deployment type
  - The estimator suggested `30` CPUs and `50g` memory
  - I settled on the `c4.8xlarge` `instance_type`, which provides `36` CPUs and `60 GiB` memory

- `associate_public_ip`
  - I think setting this to `true` is the equivalent of SourceGraph's `Auto-assign Public IP` recommendation?
