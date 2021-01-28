FROM node:10-alpine as build
RUN apk add git
RUN git clone https://github.com/shawntoffel/ghost-imgur-https.git
RUN cd ghost-imgur-https && npm install

FROM amd64/ghost:3.41.1-alpine
RUN apk add --no-cache patch
COPY --from=build ghost-imgur-https content/adapters/storage/ghost-imgur
COPY theme.patch /tmp/theme.patch
WORKDIR $GHOST_INSTALL/content.orig/themes/casper
RUN patch -p1 < /tmp/theme.patch && rm /tmp/theme.patch
WORKDIR $GHOST_INSTALL

ENV storage__active ghost-imgur
