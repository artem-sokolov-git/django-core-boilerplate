FROM python:3.12.10-slim AS base
RUN apt-get update && apt-get install -y \
    build-essential \ 
    pkg-config

WORKDIR /app
COPY pyproject.toml ./

FROM base AS base-uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

FROM base-uv AS base-uv-mysql
RUN apt-get update && apt-get install -y \
    libmariadb-dev \
    gcc && \
    rm -rf /var/lib/apt/lists/*
RUN uv lock
RUN uv sync --extra mysql --frozen
COPY . .
EXPOSE 8000
CMD ["uv", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]


FROM base-uv AS base-uv-postgres
RUN apt-get update && apt-get install -y \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/*
RUN uv lock
RUN uv sync --extra postgres --frozen
COPY . .
EXPOSE 8000
CMD ["uv", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]