FROM perl:5.26

ENV HOME=/usr/src/cas-ggircs-etl
COPY . ${HOME}
WORKDIR ${HOME}

RUN cpanm --notest -l extlib --installdeps .
RUN chmod g=u /etc/passwd && \
  ./.bin/fix-permissions ./


ENTRYPOINT [".bin/entrypoint"]
