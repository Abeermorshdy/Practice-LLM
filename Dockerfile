FROM python:3.11-slim

# Install curl (needed to download uv)
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv from official script
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Make uv available in PATH for subsequent layers
ENV PATH="/root/.local/bin:$PATH"

WORKDIR /app

COPY pyproject.toml uv.lock* ./

RUN uv sync --no-install-project

COPY . .



CMD ["uv", "run", "app.py"]
