# Use a base Python image
FROM python:3.9

# Install MKDocs
RUN pip install mkdocs==1.5.3 mkdocs-material==9.4.6 mkdocs-glightbox==0.3.4 mkdocs-with-pdf

# Copy your project files into the image
COPY . /app
WORKDIR /app

# Build the MKDocs site
RUN mkdocs build

# Use a simple HTTP server to serve the built files
WORKDIR /app/site
EXPOSE 8000
RUN useradd --create-home ubuntu
USER ubuntu
HEALTHCHECK CMD curl --fail http://localhost:8000 || exit 1
CMD [ "python", "-m", "http.server", "8000" ]
