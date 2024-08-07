# Deploy FastHTML App to a VPS with Kamal

Minimal project to deploy a [FastHtml](https://www.fastht.ml/) application on a VPS using a docker image and [Kamal deploy](https://kamal-deploy.org/).


This project uses Python, FastHTML, Docker desktop, Github container registry, Ruby and Kamal.

## Install Ruby & Kamal

- install [Ruby](https://www.ruby-lang.org/fr/) on your OS

- Next install [Kamal](https://kamal-deploy.org/)

```bash
gem install kamal
```

## Setup our local develpment environment


```bash
python -m venv ./.venv
source ./.venv/Scripts/activate
pip install -r requirements.txt
```

## Create a Github container registry and Github Access Token

https://docs.github.com/fr/packages/working-with-a-github-packages-registry/working-with-the-container-registry

https://docs.github.com/fr/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

## Secrets

Create a `.env` file with your secrets:

```bash
GHCR_TOKEN=<your github container registry access token>
GHCR_REGISTRY_USER=<your github user name>
SERVER_IPS=<your VPS IP>
```
### Build & push docker image

```bash
source .env

docker build -t fasthtml-demo .

echo $GHCR_TOKEN | docker login ghcr.io -u $GHCR_REGISTRY_USER --password-stdin
docker tag fasthtml-demo ghcr.io/$GHCR_REGISTRY_USER/fasthtml-demo
docker push ghcr.io/$GHCR_REGISTRY_USER/fasthtml-demo:latest
```

### Run the docker image locally

```bash
docker run -p 8000:8000 fasthtml-demo
```

Open http://localhost:8000 in your browser.

## Deploy to VPS


### Prepare your VPS

```bash
ssh ubuntu@vps-ip
``` 

copy or create a ssh key 

```bash
sudo apt update && apt upgrade -y
sudo apt install -y docker.io curl git
sudo usermod -a -G docker ubuntu
sudo mkdir -p /letsencrypt && sudo touch /letsencrypt/acme.json && sudo chmod 600 /letsencrypt/acme.json
```

### For initial setup

`kamal setup`

### Standard deployment

to deploy latest release

`kamal deploy`



