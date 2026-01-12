from flask import Flask
from prometheus_client import Counter, generate_latest

app = Flask(__name__)

# Prometheus metric: counts total HTTP requests
REQUEST_COUNT = Counter(
    'http_requests_total',
    'Total number of HTTP requests'
)

@app.route("/")
def home():
    REQUEST_COUNT.inc()
    return "Hello from a Kubernetes production-style app 🚀"

@app.route("/health")
def health():
    return "OK", 200

@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {
        "Content-Type": "text/plain; version=0.0.4"
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)

