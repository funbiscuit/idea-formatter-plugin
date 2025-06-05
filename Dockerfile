FROM ubuntu:jammy-20250530

ARG IDEA_VERSION=2025.1.2

WORKDIR /app

RUN apt-get update \
  && apt-get install -y unzip wget libfreetype6 fontconfig \
  && rm -rf /var/lib/apt/lists/*

RUN wget --progress=bar:force https://download.jetbrains.com/idea/ideaIC-${IDEA_VERSION}.tar.gz \
    && tar -xzf ideaIC-${IDEA_VERSION}.tar.gz \
    && rm ideaIC-${IDEA_VERSION}.tar.gz \
    && mv idea-* idea

# PythonCore 251.26094.121
# RUN wget --progress=bar:force -O python-ce.zip "https://plugins.jetbrains.com/plugin/download?rel=true&updateId=766528" \
#     && unzip python-ce.zip \
#     && rm python-ce.zip \
#     && mv python-ce idea/plugins/python-ce

WORKDIR /app/idea

COPY build/distributions/formatter-plugin plugins/formatter-plugin

COPY formatter /usr/bin/formatter

WORKDIR /data

ENTRYPOINT ["formatter"]
