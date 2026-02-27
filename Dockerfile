FROM python:3.9-slim-buster

# Install only required system packages
RUN apt update && \
    apt install -y --no-install-recommends ffmpeg curl && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only requirements first (better caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

RUN chmod +x start.sh

EXPOSE 8000

CMD ["bash", "start.sh"]