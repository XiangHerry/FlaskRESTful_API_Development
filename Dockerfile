# pull official base image
FROM python:3.11.2-slim-buster

# set working directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# new
# install system dependencies
RUN apt-get update \
  && apt-get -y install netcat gcc postgresql libpq-dev python3-dev \
  && apt-get clean

# add and install requirements
COPY ./requirements.txt .
RUN pip uninstall -y psycopg2 psycopg2-binary
RUN pip install psycopg2
RUN pip install -r requirements.txt

# add app
COPY . .

# new
# add entrypoint.sh
COPY ./entrypoint.sh .
RUN chmod +x /usr/src/app/entrypoint.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]


