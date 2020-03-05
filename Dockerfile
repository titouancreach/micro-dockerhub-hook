###########################################################
#
# Dockerfile for micro-dockerhub-hook
#
###########################################################

ARG DOCKER_LOGIN=techunitee
ARG DOCKER_PASSWORD=******

# Setting the base to nodejs 10
FROM node:10-alpine

# Maintainer
LABEL Jonas Enge

#### Begin setup ####

# Installs docker
RUN apk add --update --no-cache docker py-pip
RUN apk add bash bash-doc bash-completion

# Extra tools for native dependencies
RUN apk add --no-cache make gcc g++ python python-dev libffi-dev openssl-dev python3-dev

RUN pip install docker-compose

# Bundle app source
ENV WORKDIR /src
COPY . /src

CMD docker-login -u $DOCKER_LOGIN -p $DOCKER_PASSWORD

# Change working directory
WORKDIR "/src"

# Install dependencies
RUN npm install --production

EXPOSE 3000

# Startup
ENTRYPOINT npm start
