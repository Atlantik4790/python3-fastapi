# ---- Build stage ----
FROM python:3.12-slim AS builder

WORKDIR /build

COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# ---- Runtime stage ----
FROM python:3.12-slim

# Create non-root user/group
RUN groupadd --gid 1000 appgroup && \
    useradd --uid 1000 --gid appgroup --shell /usr/sbin/nologin --create-home appuser

WORKDIR /app

# Copy installed packages from builder (user site-packages)
COPY --from=builder /root/.local /home/appuser/.local

# Copy only application code — nothing else
COPY main.py .

# Ensure appuser owns its files and can access installed packages
RUN chown -R appuser:appgroup /app /home/appuser/.local

ENV PATH=/home/appuser/.local/bin:$PATH \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8000

USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request,os; urllib.request.urlopen(f'http://127.0.0.1:{os.environ.get(\"PORT\",8000)}/health')" || exit 1

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT}"]
