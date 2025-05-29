FROM python:3.13-alpine

WORKDIR /app

COPY requirements.txt requirements.txt

RUN apk add --no-cache git \
  && pip install --upgrade pip \
  && pip install -r requirements.txt

COPY . .
