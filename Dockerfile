FROM python:3.10.9

WORKDIR /app

COPY . .

RUN chmod 777 -R /app

RUN apt-get update && apt-get install -y \
    build-essential \
    unzip \
    libglib2.0-0 \
    libgl1-mesa-glx && \
    rm -rf /var/lib/apt/lists/* && \
    chmod 777 /app

# Upgrade pip and install dependencies
RUN pip install --upgrade pip && \
    pip install gunicorn && \
    pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["sh", "start.sh"]