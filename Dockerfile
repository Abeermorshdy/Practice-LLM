# Use an official Python image as base
FROM python:3.11

# Install uv
RUN pip install --no-cache-dir uv

# Set working directory
WORKDIR /app

# Copy dependency files first (better layer caching)
COPY pyproject.toml uv.lock* ./

# Install dependencies with uv
RUN uv sync --frozen --no-dev 

# Copy the rest of the code
COPY . .

# Set environment variables if needed
# ENV YOUR_VAR=value

# Default command (adjust to your entry point)
CMD ["uv", "run", "app.py"]