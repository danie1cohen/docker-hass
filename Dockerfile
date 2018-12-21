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

RUN apt-get -q update && apt-get -qy install \
  build-essential \
  libffi-dev \
  libssl-dev \
  curl

RUN curl -o /tmp/Python-3.6.0.tar.xz https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz && \
  cd /tmp && \
  tar xvf Python-3.6.0.tar.xz && \
  cd Python-3.6.0/ && \
  ./configure && \
  make install

RUN mkdir /config
WORKDIR /config

# open ui port
EXPOSE 8123

# expose 8989 for wemo discovery
EXPOSE 8989

COPY requirements.txt .
RUN pip install -r requirements.txt

CMD ["hass", "--config", "/config", "--open-ui"]
