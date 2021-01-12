# Run this once SSH'd into the instance
# to grab the latest updates on the release branch
# (eg, if you update docker-compose.yml)
cd /home/ec2-user/deploy-sourcegraph-docker/docker-compose
sudo git checkout release
sudo git pull
docker-compose up -d
