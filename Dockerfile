FROM perl:5.26

ENV HOME=/usr/src/cas-ggircs-etl
COPY . ${HOME}
WORKDIR ${HOME}

RUN apt-get update && \
  apt-get install -y postgresql-client jq && \
  apt-get clean

RUN cpanm --notest -l extlib --installdeps .
RUN chmod g=u /etc/passwd && \
  ./.bin/fix-permissions ./

# CPAN can install scripts. They should be available from mod_perl too.
ENV PATH="$PATH:$HOME/extlib/bin"
# And we have to set Perl include path too because mod_perl's PerlSwitches
# does not apply to them.
ENV PERL5LIB=${HOME}/extlib/lib/perl5


ENTRYPOINT [".bin/entrypoint"]
