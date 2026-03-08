# Build stage (SIMULATING VULNERABILITY: Using old, insecure base)
FROM python:3.7-slim as builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Final stage (SIMULATING VULNERABILITY: Using old, insecure base)
FROM python:3.7-slim

# Security: Run as non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

# Copy only necessary files from builder
COPY --from=builder /root/.local /home/appuser/.local
COPY . .

# Environment setup
ENV PATH=/home/appuser/.local/bin:$PATH
USER appuser

EXPOSE 5000

# Security: Use Gunicorn for production
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
