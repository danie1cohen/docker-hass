#         _       _    _                  _           _
#        / /\    / /\ / /\               / /\        / /\
#       / / /   / / // /  \             / /  \      / /  \
#      / /_/   / / // / /\ \           / / /\ \__  / / /\ \__
#     / /\ \__/ / // / /\ \ \         / / /\ \___\/ / /\ \___\
#    / /\ \___\/ // / /  \ \ \        \ \ \ \/___/\ \ \ \/___/
#   / / /\/___/ // / /___/ /\ \        \ \ \       \ \ \
#  / / /   / / // / /_____/ /\ \   _    \ \ \  _    \ \ \
# / / /   / / // /_________/\ \ \ /_/\__/ / / /_/\__/ / /
#/ / /   / / // / /_       __\ \_\\ \/___/ /  \ \/___/ /
#\/_/    \/_/ \_\___\     /____/_/ \_____\/    \_____\/
#
FROM resin/rpi-raspbian:latest

RUN mkdir -p /config
WORKDIR /config

# ui port, wemo discovery
EXPOSE 8123 8989

RUN apt-get -q update && apt-get -qy install \
  build-essential \
  libffi-dev \
  libssl-dev \
  curl

RUN curl -o \
  /tmp/Python-3.6.0.tar.xz \
  https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz && \
  cd /tmp && \
  tar xf Python-3.6.0.tar.xz && \
  cd Python-3.6.0/ && \
  ./configure >/dev/null && \
  make install

RUN ln -sfn $(which python3.6) /usr/local/bin/python
RUN ln -sfn $(which pip3) /usr/local/bin/pip
RUN python --version | grep 3.6

COPY requirements.txt .
RUN pip install -r requirements.txt

CMD ["hass", "--config", "/config", "--open-ui"]
