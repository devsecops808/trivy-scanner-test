# Use old Ubuntu with known vulnerabilities
FROM ubuntu:18.04

# Add packages that commonly have vulnerabilities
RUN apt-get update \
    && apt-get install -y \
       curl \
       wget \
       openssl \
       libssl1.0.0 \
       python2.7 \
       python-pip \
    && apt-get clean

# Add a tiny script so the image has some content
COPY app.sh /usr/local/bin/app.sh
RUN chmod +x /usr/local/bin/app.sh

CMD ["/usr/local/bin/app.sh"]

