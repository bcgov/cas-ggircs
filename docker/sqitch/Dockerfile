FROM ubuntu:xenial

RUN apt-get -qq update && \
    apt-get -qq install -y curl ca-certificates build-essential perl git make wget gawk
RUN cpan App::Sqitch

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get -qq update && \
    apt-get -qq install -y postgresql-11 libpq-dev libdbd-pg-perl
RUN cpan DBD:Pg
RUN cpan TAP::Parser::SourceHandler::pgTAP

USER postgres
WORKDIR /var/lib/postgresql
COPY ../../Makefile .
# RUN make install_sqitch
RUN make verify_installed && rm Makefile

ENV LESS=-R LC_ALL=C.UTF-8 LANG=C.UTF-8 SQITCH_EDITOR=nano SQITCH_PAGER=less

CMD ["/usr/local/bin/sqitch"]
