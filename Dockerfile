# Use old Node.js version with known vulnerabilities
FROM node:14

# Add packages (don't specify versions - let it install whatever is available)
RUN apt-get update \
    && apt-get install -y \
       nginx \
       curl \
       wget \
       openssl \
    && apt-get clean

# Add old npm version with vulnerabilities
RUN npm install -g npm@6.14.6

# Add a tiny script so the image has some content
COPY app.sh /usr/local/bin/app.sh
RUN chmod +x /usr/local/bin/app.sh

CMD ["/usr/local/bin/app.sh"]

