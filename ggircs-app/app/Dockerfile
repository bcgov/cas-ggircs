FROM debian:10

ENV SUMMARY="An image for the cas-ggircs app" \
    DESCRIPTION="This image contains the compiled cas-ggircs node app"

RUN apt-get update && \
    apt-get install -y git gnupg curl && \
    apt-get clean

ENV USER_ID=1001
ENV HOME=/root
WORKDIR ${HOME}

COPY ./ ${HOME}/

RUN git clone https://github.com/asdf-vm/asdf.git ${HOME}/asdf --branch v0.8.0
RUN cd ${HOME}/asdf && git checkout v0.8.0
ENV BASH_ENV="${HOME}/asdf/asdf.sh"
# Because asdf is loaded via BASH_ENV, all commands using adsf need to be executed using /usr/bin/env bash -c
SHELL ["/usr/bin/env", "bash", "-c"]

# The app only needs yarn and node
RUN printf "nodejs 14.15.4\nyarn 1.22.10\n" > .tool-versions
RUN cat ${HOME}/.tool-versions | cut -f 1 -d ' ' | xargs -n 1 asdf plugin-add
RUN asdf plugin-update --all
# The nodejs release team keyring is needed to install the asdf node plugin
RUN ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

RUN asdf install
RUN asdf reshim

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init
ENTRYPOINT ["dumb-init"]

ENV NODE_ENV=production
RUN PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1 CYPRESS_INSTALL_BINARY=0 \
    yarn install --frozen-lockfile --production=false && \
    yarn build:relay && \
    yarn build:next && \
    yarn install --frozen-lockfile --production=true && \
    yarn cache clean && \
    # Make everything in the home group-writable to support OpenShift's restricted SCC
    # Needs to be done as root to chown
    # same layer as yarn install to keep re-chowned files from using up several hundred MBs more space
    useradd -ms /bin/bash -d ${HOME} --uid ${USER_ID} -g root ggircs && \
    chown -R ggircs:0 ${HOME} && \
    chmod -R g+rwX ${HOME}

EXPOSE 3000
USER ${USER_ID}
WORKDIR ${HOME}

CMD ["bash", "-c", "yarn start"]
