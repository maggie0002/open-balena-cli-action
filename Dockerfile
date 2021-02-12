FROM debian:stable-slim
LABEL Description="Use the Balena CLI to perform actions"

# Install the standalone balena-cli package
RUN apt-get update && apt-get install -y \
    curl \
    unzip && \
  cd /opt/ && \
  #curl -s https://api.github.com/repos/balena-io/balena-cli/releases/latest | \
  #  grep browser_download_url.*balena-cli-v.*-linux-x64-standalone.zip | \
  #  cut -d : -f 2,3 | \
  #  xargs -n 1 curl -O -sSL && \
  curl -O -sSL https://github.com/balena-io/balena-cli/releases/download/v12.40.0/balena-cli-v12.40.0-linux-x64-standalone.zip && \
  unzip balena-cli-*-linux-x64-standalone.zip && \
  ln -s /opt/balena-cli/balena /usr/bin/ && \
  apt-get purge -y \
    curl \
    unzip && \
  apt-get autoremove -y && \
  rm -rf \
    balena-cli-*-linux-x64-standalone.zip \
    /var/lib/apt/lists/*

# Copy entrypoint into `/opt`
COPY entrypoint.sh /opt/entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/opt/entrypoint.sh"]
