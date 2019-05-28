FROM registry.access.redhat.com/ubi7/s2i-core:latest

RUN yum install -y git java-1.8.0-openjdk-devel && yum clean all
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash -
RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && yum install -y yarn && yum clean all
RUN curl -sL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o /usr/bin/lein && chmod +x /usr/bin/lein

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:0 ${APP_ROOT} && chmod -R ug+rwx ${APP_ROOT} && \
    rpm-file-permissions

USER 1001
