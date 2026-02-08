# Image name
FROM python:3.13-slim

RUN apt-get update && apt-get install -y wget && apt-get clean

RUN mkdir -p /aiinfn/.tabby/ee && cd /aiinfn && \
    useradd -md /aiinfn aiinfn && \
    chown -R aiinfn /aiinfn && \
    wget https://github.com/TabbyML/tabby/releases/download/v0.31.2/tabby_x86_64-manylinux_2_28.tar.gz && \
    tar xfvz tabby_x86_64-manylinux_2_28.tar.gz && \
    cp tabby_x86_64-manylinux_2_28/tabby ./ && \
    rm -rf tabby_x86_64-manylinux_2_28 tabby_x86_64-manylinux_2_28.tar.gz && \
    ls 

COPY ./init_tabbyml_users.py /aiinfn/
COPY ./entrypoint.sh /aiinfn/
COPY ./config.toml /aiinfn/.tabby/
COPY ./db.sqlite /aiinfn/.tabby/ee/

RUN chmod +x /aiinfn/entrypoint.sh && chown aiinfn /aiinfn/.tabby/ee

WORKDIR /aiinfn
USER aiinfn

ENTRYPOINT ["./entrypoint.sh"]
