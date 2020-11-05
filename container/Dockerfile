FROM ubuntu AS build
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
&&  apt-get -y install pandoc texlive-full python3-pip \
&&  pip install --upgrade mkdocs pyyaml python-markdown-math mkdocs-material \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

