FROM python:3.12-slim
RUN apt-get update && apt-get install -y \
    curl\
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY BackEnd/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY BackEnd/ ./BackEnd/
COPY FrontEnd/ ./FrontEnd/
ENV PYTHONPATH=/app/BackEnd
ENV PYTHONUNBUFFERED=1
ENV FLASK_APP=BackEnd/index.py
EXPOSE 7860
CMD ["gunicorn", "--bind", "0.0.0.0:7860", "BackEnd.index:app"]