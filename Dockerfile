FROM python:3.8.5

# Install dockerize (https://github.com/jwilder/dockerize)
ENV DOCKERIZE_VERSION v0.6.1

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-`dpkg --print-architecture`-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-`dpkg --print-architecture`-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-`dpkg --print-architecture`-$DOCKERIZE_VERSION.tar.gz

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY ./app/requirements.txt .

RUN apt-get update && apt-get install -qy \
    apt-utils \
    python3-psycopg2
#    libffi-dev

RUN pip3 install --upgrade pip

ENV PYTHONUNBUFFERED 1

RUN pip install -r requirements.txt

COPY . /usr/src/

RUN python manage.py makemigrations && python manage.py migrate

EXPOSE 80

CMD gunicorn --bind 0.0.0.0:80 superlists.wsgi
