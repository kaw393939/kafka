# Use an official lightweight Python image.
# 3.12-slim variant is chosen for a balance between size and utility.
FROM python:3.10.14-slim-bullseye as base
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"
# Set environment variables:
# PYTHONUNBUFFERED: Prevents Python from buffering stdout and stderr
# PYTHONFAULTHANDLER: Enables the fault handler for segfaults
# PIP_NO_CACHE_DIR: Disables the pip cache for smaller image size
# PIP_DEFAULT_TIMEOUT: Avoids hanging during install
# PIP_DISABLE_PIP_VERSION_CHECK: Suppresses the "new version" message
# POETRY_VERSION: Specifies the version of poetry to install
ENV PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=on

# Set the working directory inside the container
WORKDIR /myapp

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc libpq-dev \
    # Include pkg-config and libcairo2-dev for pycairo installation
    && apt-get install -y --no-install-recommends pkg-config libcairo2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy only the requirements, to cache them in Docker layer
COPY ./requirements.txt /myapp/requirements.txt

# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Set the working directory to where you've copied your script
WORKDIR /app

# The default command runs your Python script
CMD ["python", "main.py"]
