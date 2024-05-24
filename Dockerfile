FROM python:3.10.9

WORKDIR /app

COPY . .

RUN chmod 777 /app

RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

RUN pip install gunicorn

RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 5000

CMD ["sh", "start.sh"]
