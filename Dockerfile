FROM python:3.8.2

# Install dockerize (https://github.com/jwilder/dockerize)
RUN apt-get update && apt-get install -y wget

ENV DOCKERIZE_VERSION v0.6.1

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz

#RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
#    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
#    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz


RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY ./app/requirements.txt .


RUN apt-get update && apt-get install -qy \
    apt-utils \
    python3-psycopg2 \
    libffi-dev

RUN pip install -r requirements.txt


ENV PYTHONUNBUFFERED 1

COPY . /usr/src/


CMD gunicorn --bind 0.0.0.0:80 superlists.wsgi
