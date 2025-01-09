FROM node:22.13.0

RUN apt-get install ca-certificates

COPY root/bin/wget-spider /bin/wget-spider
COPY app /app
WORKDIR /app
ENV HOME=/app
RUN npm install
RUN mkdir -p /airflow/xcom
RUN chmod g=u -R /app /airflow/xcom
USER 1001
