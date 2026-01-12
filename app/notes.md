i started by inspecting the application itself, i.e the app.py file

layman
endpoint = a URL the app responds to
Think of an endpoint like a door to your app.
In web apps, the “knock” is an HTTP request, like when you type a URL in your browser.

As a DevOps engineer, an endpoint is more than just a URL — it is a specific interface your app exposes that your infrastructure can monitor, route traffic to, or scale based on.

3endpoints in the project
Health → /health tells Kubernetes if the pod is alive or ready for traffic.

Metrics → /metrics gives Prometheus data to monitor performance and trigger scaling.

Main service or homepage → / handles the normal workload traffic and tests connectivity.

in summary
“The application exposes three endpoints:

/ for normal traffic,

/health for Kubernetes to check if the pod is alive and ready,

/metrics for Prometheus to collect metrics.
These endpoints allow me to implement health checks, monitoring, and autoscaling, which are the main DevOps responsibilities.”


FROM python:3.11-alpine
WORKDIR /appso 
COPY . .
RUN pip install -r requirements.txt 
CMD python app.py

FROM python:3.11-alpine → start with Python on a tiny OS

WORKDIR /appso → set the folder inside the container for your app

COPY . . → copy all your project files into that folder

RUN pip install -r requirements.txt → install all Python dependencies

CMD python app.py → run your Flask app when the container starts

✅ In other words: “Start with Python, put my files in, install what I need, run the app.”


for a lighter Python Docker image

Use python:3.11-alpine ✅

pip install --no-cache-dir

Combine RUN commands to reduce layers

Multi-stage builds to remove build dependencies

Keep requirements.txt minimal

💡 Extra tip for DevOps interviews:

“I optimized my Docker image by using a lightweight Alpine base, minimizing layers, using pip install --no-cache-dir, and preparing for multi-stage builds to reduce final image size. This ensures faster deploys and smaller footprint in production.”

build image, then spin container
docker build -t funmishade/crona:v1
tagging as per standard


docker run -d -p 3028:3000 --name crona-app funmishade/crona:v1

docker run -p 3028:3000 funmishade/crona:v1


"I want to write the Kubernetes manifests myself rather than being given them. For this app, how do I determine which Kubernetes objects are actually needed? I know a Deployment is required, but I’m unsure if objects like Secrets or ConfigMaps are necessary. What should I look for in the application to decide which objects to create?"

Start with what your app actually does

Look at your Flask app (app.py) and the files in the project. Ask yourself:

Does it store any sensitive information?

DB passwords, API keys, tokens → need Secret

No secrets? ✅ You don’t need a Secret yet

Does it read/write files to disk?

Local disk persistence → might need a PersistentVolume and PersistentVolumeClaim

Your app is stateless → no PV needed

Does it need configuration outside of code?

Environment variables, config files → could use ConfigMap

Right now, simple Flask app → you can skip ConfigMap

Does it accept incoming traffic?

Your /, /health, /metrics endpoints → need a Service to expose Pods

Do you want multiple replicas?

If yes → you need a Deployment (or ReplicaSet)

If scaling → HPA (Horizontal Pod Autoscaler)

Do you want Kubernetes to auto-check if it’s alive?

Yes → add livenessProbe and readinessProbe in Deploymentcd ..