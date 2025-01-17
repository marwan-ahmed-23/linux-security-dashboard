# Use an official Python image
FROM python:3.9-slim

# Set optional environment variables (can be configured in docker-compose or during runtime)
ENV FLASK_ENV production
ENV BASIC_AUTH_USERNAME admin
ENV BASIC_AUTH_PASSWORD secret
ENV SLACK_WEBHOOK_URL ""

# Create the working directory
WORKDIR /app

# Copy project files (use .dockerignore to reduce image size if needed)
COPY backend /app/backend
COPY frontend /app/frontend
COPY backend/requirements.txt /app/backend/requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r /app/backend/requirements.txt

# Expose port 5000 (default port for Flask)
EXPOSE 5000

# Run Flask when the container starts
CMD ["python", "/app/backend/app.py"]
