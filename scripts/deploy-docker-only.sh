#!/bin/bash
# Deploy using Docker without Docker Compose

# Build the Docker image
echo "Building Docker image..."
docker build -t app-name .

# Stop and remove any existing container with the same name
echo "Stopping any existing containers..."
docker stop app-container 2>/dev/null || true
docker rm app-container 2>/dev/null || true

# Run the new container
echo "Starting new container..."
docker run -d \
  --name app-container \
  -p 8080:80 \
  -e VITE_SUPABASE_URL=${VITE_SUPABASE_URL} \
  -e VITE_SUPABASE_ANON_KEY=${VITE_SUPABASE_ANON_KEY} \
  -e VITE_APP_URL=${VITE_APP_URL} \
  --restart unless-stopped \
  app-name

echo "Deployment completed! Your app is running at http://localhost:8080"