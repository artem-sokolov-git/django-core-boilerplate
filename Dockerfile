FROM python:3.12.10-slim AS base
RUN apt-get update && apt-get install -y \
    build-essential \ 
    pkg-config
WORKDIR /app
COPY pyproject.toml ./

FROM base AS base-uv
COPY --from=ghcr.io/astral-sh/uv:0.7.11 /uv /uvx /usr/local/bin/
RUN uv lock

FROM base-uv AS base-uv-mysql
RUN apt-get update && apt-get install -y libmariadb-dev gcc
RUN uv sync --extra mysql --frozen

FROM base-uv-mysql AS base-uv-mysql-drf
RUN uv sync --extra drf --frozen

FROM base-uv AS base-uv-psql
RUN apt-get update && apt-get install -y libpq-dev
RUN uv sync --extra psql --frozen

FROM base-uv-psql AS base-uv-postgres-drf
RUN uv sync --extra drf --frozen

RUN rm -rf /var/lib/apt/lists/*
COPY . .