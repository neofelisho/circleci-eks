FROM docker:17.12.0-ce as static-docker-source

FROM debian:stretch

COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker
RUN apt update -qqy && apt install -qqy \
    curl \
    wget \
    git \
    ssh \
    tar \
    gzip \
    unzip \
    ca-certificates \
    gettext
WORKDIR /app
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm -rf /app
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v1.17.3/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
RUN docker --version && kubectl version --client