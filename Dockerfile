FROM frodenas/ubuntu
MAINTAINER Ferran Rodenas <frodenas@gmail.com>

# Install RabbitMQ 3.5
RUN DEBIAN_FRONTEND=noninteractive && \
    cd /tmp && \
    wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc && \
    apt-key add rabbitmq-signing-key-public.asc && \
    echo "deb http://www.rabbitmq.com/debian/ testing main" | tee /etc/apt/sources.list.d/rabbitmq.list && \
    apt-get update && \
    apt-get install -y --force-yes rabbitmq-server=3.5.6-1 && \
    rabbitmq-plugins enable rabbitmq_management && \
    service rabbitmq-server stop && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /.firstrun

# Command to run
#ENTRYPOINT ["/scripts/run.sh"]
#/scripts/run.sh to run manually

# Expose our log volumes
VOLUME ["/var/log/rabbitmq"]
