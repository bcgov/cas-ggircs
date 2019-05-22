FROM cas-ggircs-sqitch:0.9999

USER root
RUN adduser --disabled-password --shell /bin/bash ggircs
USER ggircs

WORKDIR /home/ggircs
COPY ../../ ./
RUN sqitch config --local -l

ENTRYPOINT []
CMD []
