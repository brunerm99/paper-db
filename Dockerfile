# Base image
FROM python:3.9

# Some normal Python optimizations
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update && \
    apt-get install -y google-chrome-stable git postgresql && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /paper-db

# Package management
RUN pip3 install --upgrade pip setuptools wheel && \
    pip3 install poetry
COPY pyproject.toml /paper-db/
# COPY poetry.lock /paper-db/
RUN poetry config virtualenvs.create false && \
  poetry install --no-interaction --no-ansi -vvv


# Copy directories
COPY . /paper-db/

# Log file
RUN mkdir -p /paper-db/logs

# Exec access to init script
RUN chmod +x /paper-db/scripts/docker/init.sh

# Dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
