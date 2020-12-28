FROM python:3.7-slim-buster

# Never prompt the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

RUN apt-get update && \
    apt-get install -y build-essential libpq-dev && \
    apt-get clean

COPY lib /lib
WORKDIR /lib
RUN pip install -r requirements.txt
RUN chmod g=u -R /lib
USER 1001
ENV HOME=/lib
ENTRYPOINT ["python", "extract_zips.py"]
