# Use old Node.js version with known vulnerabilities
FROM node:14

# Add vulnerable Ubuntu packages
RUN apt-get update \
    && apt-get install -y \
       nginx=1.18.0-0ubuntu1 \
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

