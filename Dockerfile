FROM elixir:1.6.6-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN mkdir /app
WORKDIR /app
COPY . .
RUN mix do local.hex --force, deps.get, compile
