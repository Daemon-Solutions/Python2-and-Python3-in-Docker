#!/usr/bin/env bash

usage()
{
  echo "Usage: $0 terraform_version"
  exit 1
}

get_tf()
{
  echo "Downloading terraform_$1_linux_amd64.zip"
  wget https://releases.hashicorp.com/terraform/$1/terraform_$1_linux_amd64.zip
  wget https://releases.hashicorp.com/terraform/$1/terraform_$1_SHA256SUMS

  csum=$(sha256sum terraform_$1_linux_amd64.zip | cut -d " " -f1)
  fsum=$(grep linux_amd64 terraform_$1_SHA256SUMS | cut -d " " -f1)

  if [ $csum == $fsum ]
  then
    unzip terraform_$1_linux_amd64.zip -d /usr/bin
    chmod +x /usr/bin/terraform
  else
    echo "SHA verification failed."
    exit 1
  fi
}

if [ $# -ne 1 ] ; then
  usage
else
  get_tf $1
fi
