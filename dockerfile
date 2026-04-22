FROM python:3.14-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl\
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY BackEnd/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY BackEnd/ .
ENV FLASK_APP=index.py
EXPOSE 7860
CMD ["gunicorn", "--bind", "0.0.0.0:7860", "index:app"]