# Run `chmod u+x connect.sh` in the directory that contains this file.
# Place tf-sourcegraph-test.pem adjacent to this file.
# Then run `./connect.sh`
chmod 400 tf-sourcegraph-test.pem
ssh -i "tf-sourcegraph-test.pem" ec2-user@ec2-3-139-6-228.us-east-2.compute.amazonaws.com
