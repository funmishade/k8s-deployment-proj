
# =========================
# Build stage (builder)
# =========================
# Use a lightweight Python image to install dependencies
FROM python:3.11-alpine AS builder

# Set working directory inside the builder container
WORKDIR /app

# Copy ONLY the requirements file
# This improves Docker layer caching — dependencies are rebuilt
# only when requirements.txt changes
COPY requirements.txt .

# Install Python dependencies into the user directory (/root/.local)
# --no-cache-dir prevents pip from storing temporary files
# --user avoids installing packages globally
RUN pip install --user --no-cache-dir -r requirements.txt


# =========================
# Final stage (runtime)
# =========================
# Start again from a clean Python Alpine image
# This stage will be smaller because it excludes build-time layers
FROM python:3.11-alpine

# Set working directory for the running application
WORKDIR /app

# Copy ONLY the installed Python dependencies from the builder stage
# This avoids carrying over build tools and cache files
COPY --from=builder /root/.local /root/.local

# Copy the application source code into the final image
COPY . .

# Add the user-installed Python binaries to PATH
# This allows Python to find the installed packages at runtime
ENV PATH=/root/.local/bin:$PATH

# Command that runs when the container starts
# Starts the Flask application
CMD ["python", "app.py"]



# Dockerfile for a simple Flask application
# FROM python:3.11-alpine
# WORKDIR /appso 
# COPY . .
# RUN pip install -r requirements.txt 
# CMD python app.py


# FROM python:3.11-alpine → start with Python on a tiny OS

# WORKDIR /appso → set the folder inside the container for your app

# COPY . . → copy all your project files into that folder

# RUN pip install -r requirements.txt → install all Python dependencies

# CMD python app.py → run your Flask app when the container starts

# ✅ In other words: “Start with Python, put my files in, install what I need, run the app.”

