FROM elixir:1.6.6-alpine

RUN mkdir /app
WORKDIR /app
COPY . .
RUN mix do local.hex --force, deps.get, compile
