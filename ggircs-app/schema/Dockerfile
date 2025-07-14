# Docker build should be run from parent directory
FROM perl:5.32.1

ENV USER_ID=1001
ENV HOME=/root
COPY . ${HOME}/schema/
WORKDIR ${HOME}/schema

RUN apt-get update && \
  apt-get install -y postgresql-client && \
  apt-get clean

# CPAN needs to install dependencies for all schemas, one directory up
RUN cpanm --notest --local-lib ../extlib --installdeps .

# CPAN can install scripts. They should be available from mod_perl too.
ENV PATH="$PATH:$HOME/extlib/bin"
# And we have to set Perl include path too because mod_perl's PerlSwitches
# does not apply to them.
ENV PERL5LIB=${HOME}/extlib/lib/perl5

# Make everything in the home group-writable, to support restricted SCC
# Needs to be done as root to chown
RUN useradd -ms /bin/bash -d ${HOME} --uid ${USER_ID} ggircs
RUN chown -R ggircs:0 ${HOME} && \
  chmod -R g+rwX ${HOME}

USER ${USER_ID}
WORKDIR ${HOME}
