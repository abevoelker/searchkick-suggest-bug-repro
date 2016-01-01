FROM ubuntu:trusty

# Update APT
RUN DEBIAN_FRONTEND=noninteractive apt-get update

# Install build dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  wget \
  python-software-properties \
  software-properties-common

# Add Oracle Java maintainers and automatically select the Oracle License
RUN apt-add-repository ppa:webupd8team/java &&\
  echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections

# Add Elasticsearch Public Signing Key
RUN wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - &&\
  echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list

# Install Java 8 and Elasticsearch
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
  apt-get install -y oracle-java8-installer elasticsearch

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl lsof

# Clean up APT and temporary files when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER elasticsearch

CMD ["/usr/share/elasticsearch/bin/elasticsearch", "-Des.network.host=0.0.0.0", "-p", "/var/run/elasticsearch/elasticsearch.pid", "--default.path.home=/usr/share/elasticsearch", "--default.path.logs=/var/log/elasticsearch", "--default.path.data=/var/lib/elasticsearch", "--default.path.conf=/etc/elasticsearch"]

EXPOSE 9200 9300
