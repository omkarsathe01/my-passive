FROM python:3.10.9

WORKDIR /app

COPY . .

# make /app executable

# run commands separately

RUN apt-get update && apt-get install -y \
    build-essential \
    unzip \
    libglib2.0-0 \
    libgl1-mesa-glx

# Upgrade pip and install dependencies
RUN pip install --upgrade pip && \
    pip install gunicorn && \
    pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["sh", "start.sh"]
