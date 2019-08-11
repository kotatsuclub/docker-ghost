FROM node:10-alpine as build
RUN apk add git
RUN wget https://github.com/kotatsuclub/Casper-KotatsuClub/archive/2.10.6-kotatsuclub.zip && unzip 2.10.6-kotatsuclub.zip
RUN git clone https://github.com/shawntoffel/ghost-imgur-https.git
RUN cd ghost-imgur-https && npm install

FROM ghost:2.27.0-alpine
COPY --from=build Casper-KotatsuClub-2.10.6-kotatsuclub content/themes/Casper-KotatsuClub-2.10.6-kotatsuclub
COPY --from=build ghost-imgur-https content/adapters/storage/ghost-imgur
ENV storage__active ghost-imgur
