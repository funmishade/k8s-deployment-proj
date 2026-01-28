#!/bin/bash

# -----------------------------
# SonarQube Docker Compose Setup
# -----------------------------

# Go to folder where docker-compose.yml is located
cd "$(dirname "$0")"

# Check Docker installation
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Install Docker Desktop with WSL 2 integration first."
    exit 1
fi

# Check Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose not found. Install Docker Compose."
    exit 1
fi

# Start SonarQube + PostgreSQL
docker-compose up -d

echo "✅ SonarQube + PostgreSQL started!"
echo "Access SonarQube: http://localhost:9000"
echo "Default login: admin / admin"
