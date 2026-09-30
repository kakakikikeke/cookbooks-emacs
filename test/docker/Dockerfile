FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    ANSIBLE_NOCOLOR=1 \
    HOME=/home/emacs-test \
    OWNER=emacs-test \
    GROUP=emacs-test

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

RUN useradd --create-home --shell /bin/bash emacs-test \
    && printf 'emacs-test ALL=(ALL) NOPASSWD: ALL\n' > /etc/sudoers.d/emacs-test \
    && chmod 0440 /etc/sudoers.d/emacs-test

COPY test/docker/test.sh /usr/local/bin/test-ansible
RUN chmod 0755 /usr/local/bin/test-ansible

WORKDIR /workspace
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD ansible-playbook --version >/dev/null
USER emacs-test
ENTRYPOINT ["/usr/local/bin/test-ansible"]