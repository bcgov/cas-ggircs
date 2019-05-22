FROM docker.io/postgres:11.2
USER root
RUN apt-get update && apt-get install -y git make postgresql-server-dev-all postgresql-common
RUN cpan TAP::Parser::SourceHandler::pgTAP
COPY ../../Makefile .
RUN make pgtap && cd pgtap && make && make install && cd .. && rm -r pgtap
RUN chown -R postgres:postgres /var/lib/postgresql
USER postgres
