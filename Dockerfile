FROM m0kimura/ubuntu-base

ENV TERM=xterm
RUN apt-get update && \
    apt-get -qq install \
      curl \
      ca-certificates \
      libgtk2.0-0 \
      libxtst6 \
      libnss3 \
      libgconf-2-4 \
      libasound2 \
      fakeroot \
      gconf2 \
      gconf-service \
      libcap2 \
      libnotify4 \
      libxtst6 \
      libnss3 \
      gvfs-bin \
      xdg-utils \
      composer \
      libxss1 \
      libcanberra-gtk-module \
      libxkbfile1 \
      python -qq -y --allow-unauthenticated --no-install-recommends && \
    curl -L https://github.com/atom/atom/releases/download/v1.16.0/atom-amd64.deb > /tmp/atom.deb && \
    dpkg -i /tmp/atom.deb && \
    rm -f /tmp/atom.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY atom /home/${user}/.atom/
RUN mkdir /source && \
    chown -R ${user}:${user} /home/${user} && \
    chown -R ${user}:${user} /source

VOLUME /home/${user}
VOLUME /source
WORKDIR /home/${user}
USER ${user}
CMD atom -f /source

