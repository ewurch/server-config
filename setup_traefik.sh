# Activate swarm mode and make current machine a manager
docker swarm init

# Create the newtowrk that will be used by all services accessible by Traefik
docker network create -d overlay traefik-public

# Add a label to node so traefik always deploys to it
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID

echo "Enter the email address you want to use for Let's Encrypt:"
read EMAIL

echo "Enter the domain you want to use for Traefik:"
read DOMAIN

echo "Enter the password to access Traefik's dashboard:"
read PASSWORD
export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)
echo $HASHED_PASSWORD

# run docker compose file for treafik
docker stack deploy -c docker-compose.yml traefik