FROM elixir:1.12.3

ENV MIX_ENV=prod

WORKDIR /app

RUN mix local.rebar --force
RUN mix local.hex --force

COPY . .