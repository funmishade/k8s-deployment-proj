githubactions
commit - test - build - push - deploy
use same tool for cicd pipeline no neec for 3rd party
setup pipeline is easy
tool for developer

cicd integrates with other tools - easy github
on github, click actions, choose the one closet to your applicatio, get the template

on:
 push , pull request
 this is an event
 you will see list of events in the documentation

 action - reusable lines of code
 uses" selects an action
 run" 
 matrix when you are using multiple os
 you can save secrets 


 1️⃣ What determines the steps in a CI/CD pipeline?
Short answer:

The application + risk + environment determine the pipeline.

There is no universal pipeline.

Instead, every pipeline is derived from three inputs:

A. What are you building? (Application type)

Examples:

App type	Typical pipeline needs
Static site	Build + deploy
Backend API	Build, unit tests, image scan
Microservice	Build, test, scan, deploy
Financial / Security app	SAST, DAST, secrets scan, compliance
Regulated (banking, health)	Everything + approvals

👉 Your project:
Containerized web app deployed to Kubernetes

So minimum responsible pipeline is:

Build image

Scan image

Push image

Deploy

B. What is the risk if this breaks or is hacked?

This is the most important factor.

Risk level	What you add
Low (internal tool)	Basic build & deploy
Medium (public API)	SAST + image scan
High (payments, auth)	SAST + DAST + secrets + policy checks

👉 Your project:

Public-facing

Kubernetes

Portfolio meant to show DevSecOps maturity

✅ That justifies:

Trivy (image & dependency scanning)

(Optional but strong) SAST (SonarQube or CodeQL)

C. Where is it running?
Environment	Implications
Local	Minimal
Cloud VM	Some security
Kubernetes	Stronger security, automation, RBAC

Kubernetes raises the bar:

Image scanning becomes important

Declarative deployment

GitOps mindset

2️⃣ Why these steps specifically?

Let’s map your steps to real-world reasoning, not guesswork.

✅ Checkout code

Why?
The runner is empty. No code = nothing to build.

Mandatory in 99% of pipelines.

✅ Login to Docker registry

Why?

You can’t push images anonymously (except Docker Hub public, but don’t rely on that)

Authentication must be non-interactive

Required whenever you push images.

✅ Build Docker image

Why?

Kubernetes runs containers

Docker image is your deployable artifact

This is your “binary”

✅ Scan image with Trivy

Why?

Images often contain vulnerable OS packages

Dependencies may have CVEs

This catches issues before production

This is supply-chain security, not “extra”.

✅ Push image

Why?

Kubernetes pulls images from a registry

CI must produce immutable artifacts

✅ Configure kubectl

Why?

CI runner does not know your cluster

You must explicitly authenticate

✅ Deploy to Kubernetes

Why?

CI/CD = automation to production (or staging)

3️⃣ Can you integrate SonarQube? YES — but when does it make sense?
SonarQube = SAST (Static Application Security Testing)

It analyzes:

Code smells

Bugs

Security vulnerabilities

Technical debt

When is SAST justified?
Situation	Use SAST?
Simple demo app	Optional
Portfolio project	✅ YES
Enterprise app	Mandatory
Regulated environment	Mandatory

👉 For your project:

SonarQube makes sense

It signals DevSecOps awareness

You don’t need everything, but showing intentional security matters

Important truth interviewers expect you to know:

Not every project needs every scan

Adding tools blindly is a red flag.

4️⃣ What determines SAST vs DAST vs others?

This is a classic interview question, so learn this framing 👇

SAST (Static)

Runs on source code

Early feedback

Fast

Finds coding issues

📌 Example tools:

SonarQube

CodeQL

DAST (Dynamic)

Runs against a running app

Finds runtime vulnerabilities

📌 Example tools:

OWASP ZAP

Burp

Image / Dependency scanning

Scans third-party risk

📌 Example:

Trivy

Grype

What determines which ones you use?
Factor	Decision
Early feedback needed	SAST
Public-facing app	DAST
Containers	Image scan
Compliance	All

👉 For this project, a reasonable set is:

Trivy (image)

Optional SonarQube (SAST)

That’s balanced, not over-engineered.

5️⃣ How many tests should a project have?

There’s a famous rule called the testing pyramid:

        DAST / E2E (few)
     Integration tests
  Unit tests (many)


CI/CD pipelines usually:

Always run unit tests

Sometimes run integration

Run DAST on staging or nightly

For your portfolio:

You can explain this even if you don’t implement all of it

Explanation matters as much as tooling

6️⃣ What does depends-on (needs) actually mean?

This is VERY important.

In GitHub Actions it’s called needs, not depends-on.

Without needs

Jobs run in parallel.

With needs

Jobs run in order and share results logically.

Example (conceptual)
jobs:
  build:
    runs-on: ubuntu-latest

  scan:
    needs: build
    runs-on: ubuntu-latest

  deploy:
    needs: scan
    runs-on: ubuntu-latest

What this means:

scan runs only if build succeeds

deploy runs only if scan succeeds

This is how you enforce quality gates.

Why this matters

Without needs:

You could deploy even if scan fails

That’s a security risk

7️⃣ GitHub Actions vs GitLab CI — which is better?

There is no absolute winner.

GitHub Actions	GitLab CI
Best GitHub integration	Best end-to-end DevOps
Huge marketplace	Native CI/CD
Easy to start	Very structured
YAML can get messy	Cleaner pipeline logic

👉 Industry reality:

GitHub Actions = most common

GitLab CI = very respected

Knowing either well is enough.

8️⃣ Should you use your own runner?
Default runners:

Free (with limits)

Ephemeral

Secure

Good for most projects

Self-hosted runners:

Needed when:

You need private network access

Heavy workloads

Compliance

Custom tooling

👉 For this project:
❌ Not required
✅ But knowing when to use one is important

You already do.

9️⃣ How your pipeline will evolve (real-world view)
Phase 1 (now)

Build

Scan

Push

Deploy

Phase 2 (advanced)

Add SAST

Add approval gates

Add environment separation

Phase 3 (senior-level)

GitOps (ArgoCD)

Policy as Code (OPA)

Progressive delivery

Final takeaway (this is key)

Pipelines are not about tools — they’re about risk management and confidence.

You now understand:

Why steps exist

When to add security

When not to add security

How to justify decisions in interviews

Next step (only when you’re ready):

We will:

Design the final job structure

Decide where SonarQube fits

Then write YAML with purpose, not blindly


3️⃣ Now let’s explain the concepts you asked about (this is IMPORTANT)
🔹 Feature branch → Validate

Validate = “Is this code even worth reviewing?”

When you push to a feature branch:

The code is unfinished

The goal is fast feedback

So we run:

Build

Lint

Unit tests

(Optional) SAST

❌ We do NOT:

Deploy

Push images

Touch production-like environments

👉 Validation answers:

“Does this code compile, test, and follow rules?”

🔹 Pull Request → Gate

Gate = “Should this code be allowed into main?”

This is a quality checkpoint.

At PR time:

Code is reviewed

CI results are visible

GitHub can block the merge if checks fail

This is where:

Tests must pass

Security checks matter more

Standards are enforced

👉 Gate answers:

“Is this code safe and acceptable to merge?”

Think of it as:
🚪 A door to main — CI decides if it opens.

🔹 Push to main → Build image + deploy

Main branch means:

Code was reviewed

CI checks passed

Team trusts it

Now we can:

Build Docker image

Scan image (Trivy)

Push image

Deploy to Kubernetes

👉 This answers:

“Ship it.”

What does feature/* mean?
branches:
  - feature/*

👉 * is a wildcard

It means:

“Match anything after feature/”

Examples that MATCH feature/*

These branch names will trigger the workflow:

feature/login
feature/add-hpa
feature/nginx-ingress
feature/fix-bug-123

Language	Unit Testing Framework	Usage in CI/CD
Python	pytest / unittest	Run pytest in workflow
Go	testing package + go test	go test ./... in pipeline
Java	JUnit / TestNG	mvn test or gradle test
Node.js	Jest / Mocha	npm test