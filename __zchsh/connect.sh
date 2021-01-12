# Run `chmod u+x connect.sh` in the directory that contains this file.
# Place tf-sourcegraph-test.pem adjacent to this file.
# Run `terraform apply` and update the address after ec2-user@
# Then run `./connect.sh`
chmod 400 tf-sourcegraph-test.pem
ssh -i "tf-sourcegraph-test.pem" ec2-user@ec2-52-15-124-220.us-east-2.compute.amazonaws.com
