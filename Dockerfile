FROM alpine:3.14

# Add a tiny script so the image has some content
COPY app.sh /usr/local/bin/app.sh
RUN chmod +x /usr/local/bin/app.sh \
    && apk add --no-cache ca-certificates curl openssl

CMD ["/usr/local/bin/app.sh"]

