FROM node:22-alpine as build
RUN apk add git
RUN git clone https://github.com/shawntoffel/ghost-imgur-https.git
RUN cd ghost-imgur-https && npm install

FROM amd64/ghost:6.0.3-alpine
RUN apk add --no-cache patch gettext
COPY --from=build ghost-imgur-https content/adapters/storage/ghost-imgur
COPY theme.patch.template /tmp/theme.patch.template
RUN chown node:node /tmp/theme.patch.template
COPY docker-entrypoint.patch /tmp/docker-entrypoint.patch
RUN patch -s /usr/local/bin/docker-entrypoint.sh /tmp/docker-entrypoint.patch && rm /tmp/docker-entrypoint.patch
ENV DISQUS_SHORTNAME="EXAMPLE" \
    storage__active=ghost-imgur