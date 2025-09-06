# Use Debian Bullseye with known vulnerabilities
FROM debian:bullseye

# Add packages that commonly have vulnerabilities
RUN apt-get update \
    && apt-get install -y \
       curl \
       wget \
       openssl \
       nginx \
       python3 \
       git \
    && apt-get clean

# Add a tiny script so the image has some content
COPY app.sh /usr/local/bin/app.sh
RUN chmod +x /usr/local/bin/app.sh

CMD ["/usr/local/bin/app.sh"]

