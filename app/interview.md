“The application is intentionally lightweight and stateless, exposing three endpoints:

/ handles normal traffic and simulates load,

/health serves as the liveness and readiness probe for Kubernetes,

/metrics provides Prometheus metrics for observability and HPA-based autoscaling.
Although the app itself is simple, it allows me to demonstrate production-grade platform concerns like reliability, scalability, and monitoring — which are core responsibilities for a DevOps engineer.”


FROM PYTHON:slim3.5
WORKDIR /app.py
COPY . .
RUN requirements.txt
CMD python app.py








ISSUED ENCOUNTERED
after building the dockerfile, the app, /metric and /health were unreachable. to debug this i 