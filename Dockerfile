FROM ubuntu:14.04

# Install system dependencies.
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C7917B12
RUN echo 'deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main' | tee /etc/apt/sources.list.d/nodejs.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y -q python build-essential nodejs git

# Install application dependencies.
RUN npm install coffee-script -g

RUN git clone https://github.com/rs/pushd.git /opt/pushd/
RUN cd /opt/pushd/ && npm install
ADD ./main.sh /usr/local/bin/main.sh
ADD ./settings.coffee /opt/pushd/settings.coffee

EXPOSE 80

CMD ["/usr/local/bin/main.sh"]
