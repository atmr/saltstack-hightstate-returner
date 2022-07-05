FROM debian:stretch
ARG python_version=py3
ARG salt_version
RUN   apt-get update -y \
        && apt-get install -y curl gnupg2 apt-transport-https \
        && curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/$python_version/debian/9/amd64/$salt_version/salt-archive-keyring.gpg \
        && echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/$python_version/debian/9/amd64/$salt_version stretch main" | tee /etc/apt/sources.list.d/salt.list \
        && cat /etc/apt/sources.list.d/salt.list \
        && apt-get update -y \
        && apt-get install -y salt-master salt-minion \
        && rm -rf /var/lib/apt/lists/*
COPY etc /etc/salt/
COPY salt /srv/salt/
ENV SALT_TAG=$salt_version@$python_version
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD ["test"]
