FROM python:3.10.9

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
    build-essential \
    unzip \
    libglib2.0-0 \
    libgl1-mesa-glx

RUN pip install --upgrade pip && \
    pip install gunicorn && \
    pip install --no-cache-dir -r requirements.txt && \
    chmod +x /app/start.sh

EXPOSE 5000

CMD ["sh", "start.sh"]
