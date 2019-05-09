ARG DOCKER_SQITCH_IMAGE=wenzowski/sqitch
ARG DOCKER_SQITCH_TAG=0.9999

FROM ${DOCKER_SQITCH_IMAGE}:${DOCKER_SQITCH_TAG}

USER root
RUN adduser --disabled-password --shell /bin/bash ggircs
USER ggircs

WORKDIR /home/ggircs
COPY ./ ./
RUN sqitch config --local -l

ENTRYPOINT []
CMD []
