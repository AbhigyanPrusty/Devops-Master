# Simple Dockerfile for Trivy scanning
FROM nginx:latest

# Add a simple HTML file
RUN echo '<h1>Hello DevSecOps</h1>' > /usr/share/nginx/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
