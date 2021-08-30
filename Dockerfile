FROM ubuntu:18.04

# Arguments with defaults set
ARG TERRAFORM_VERSION="1.0.5"

LABEL maintainer="tgremlin82 <tenisonallan@gmail.com>"
LABEL terraform_version=${TERRAFORM_VERSION}
LABEL aws_cli_version=2

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TERRAFORM_VERSION=$TERRAFORM_VERSION
ENV aws=/usr/bin/local/aws

# Install packages
RUN apt-get update \
	&& apt-get install -y \
	curl \
	python3 \
	python3-pip \
	python3-boto \
	unzip \
	&& curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
	&& unzip '*.zip' -d /usr/local/bin \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* *.zip
# Install AWS CLI using curl and unzip
RUN mkdir /tmp/aws && cd /tmp/aws \
&& curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
&& unzip awscliv2.zip \
&& ./aws/install \
&& cd / \
&& rm -rf /tmp/*

