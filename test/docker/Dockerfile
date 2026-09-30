FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    ANSIBLE_NOCOLOR=1 \
    HOME=/root \
    OWNER=root \
    GROUP=root

ENV PATH="/opt/ansible/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        python3 \
        python3-venv \
        sudo \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/ansible \
    && /opt/ansible/bin/pip install --no-cache-dir ansible-core

COPY test/docker/test.sh /usr/local/bin/test-ansible
RUN chmod 0755 /usr/local/bin/test-ansible

WORKDIR /workspace
ENTRYPOINT ["/usr/local/bin/test-ansible"]