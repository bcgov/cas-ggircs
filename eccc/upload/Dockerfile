FROM node:lts-alpine

RUN apk update
RUN apk add --no-cache wget bash

COPY root/bin/wget-spider /bin/wget-spider
COPY app /app

WORKDIR /app
ENV HOME=/app
RUN npm install
RUN mkdir -p /airflow/xcom
RUN chmod g=u -R /app /airflow/xcom
USER 1001
