# Image name
FROM python:3.13-slim

RUN apt-get update && apt-get install -y wget && apt-get clean

RUN mkdir -p /aiinfn/.tabby && cd /aiinfn && \
    useradd -md /aiinfn aiinfn && \
    wget https://github.com/TabbyML/tabby/releases/download/v0.32.0/tabby_x86_64-manylinux_2_28.tar.gz && \
    tar xfvz tabby_x86_64-manylinux_2_28.tar.gz && \
    ls 

COPY ./init_tabbyml_users.py /aiinfn/
COPY ./entrypoint.sh /aiinfn/
COPY ./config.toml /aiinfn/.tabby/

WORKDIR /aiinfn
USER aiinfn

ENTRYPOINT ["./entrypoint.sh"]
