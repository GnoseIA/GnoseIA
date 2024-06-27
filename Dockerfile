FROM python:3.11-slim
ENV PYTHONUNBUFFERED=True
WORKDIR /app
COPY requirement.txt .
RUN pip install --no-cache-dir -r requirement.txt
COPY . .
EXPOSE 5000
CMD exec gunicorn --bind :5000 run:app