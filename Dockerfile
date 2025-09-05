FROM ubuntu:20.04

# Add a tiny script so the image has some content
COPY app.sh /usr/local/bin/app.sh
RUN chmod +x /usr/local/bin/app.sh \
    && apt-get update \
    && apt-get install -y curl wget openssl \
    && apt-get clean

CMD ["/usr/local/bin/app.sh"]

