FROM gitpod/workspace-full:latest

## install: heroku cli
USER root
RUN  curl https://cli-assets.heroku.com/install-ubuntu.sh | sh