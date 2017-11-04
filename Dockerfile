FROM opensuse:tumbleweed

COPY travis-daps /usr/bin/
ENV LC_ALL=en_US.UTF-8
# RUN mkdir -p /usr/src/app
# WORKDIR /usr/src/app

# we need to install curl for downloading/installing the GPG key
# see https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#/build-cache
# why we need "zypper clean -a" at the end:
RUN zypper --non-interactive in --no-recommends curl && zypper clean -a

# Set a higher priority for our doc repositories:
RUN zypper ar -f -p 95 https://download.opensuse.org/repositories/Documentation:/Tools/openSUSE_Tumbleweed/ Documentation:Tools
RUN zypper ar -f -p 95 https://download.opensuse.org/repositories/Publishing/openSUSE_Tumbleweed/ Publishing

# import the OBS GPG key:
RUN rpm --import https://build.opensuse.org/projects/Publishing/public_key
RUN rpm --import https://build.opensuse.org/projects/Documentation:Tools/public_key

RUN zypper --non-interactive in --no-recommends \
    daps \
    docbook5-xsl-stylesheets \
    suse-xsl-stylesheets

# Run a short check to see if everything is ok
RUN daps --version
