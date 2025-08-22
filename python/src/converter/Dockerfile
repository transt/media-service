FROM python:3.10-slim-bullseye

# Install system dependencies for mysqlclient
RUN apt-get update \
  && apt-get install -y --no-install-recommends --no-install-suggests \
  build-essential ffmpeg \
  && pip install --no-cache-dir --upgrade pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

COPY ./requirements.txt /app
RUN pip3 install --no-cache-dir --requirement /app/requirements.txt
COPY . /app

CMD ["python3", "consumer.py"]
