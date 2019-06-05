FROM node:10-alpine as build
RUN apk add git
RUN git clone https://github.com/shawntoffel/ghost-imgur-https.git
RUN cd ghost-imgur-https && npm install

FROM ghost:2.23.2-alpine
COPY --from=build ghost-imgur-https content/adapters/storage/ghost-imgur
ENV storage__active ghost-imgur