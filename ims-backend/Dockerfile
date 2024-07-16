FROM python:3.12.3-bullseye

# Declare docker arguments
ARG HOST=${HOST:-"0.0.0.0"}
ARG PORT=${PORT:-8000}
ARG WORKING_DIRECTORY=/app/ElectronicsStoreIMS

# Create app working directory
RUN mkdir -p ${WORKING_DIRECTORY}

# Move to working directory
WORKDIR ${WORKING_DIRECTORY}

# Copy project content into new working directory
COPY . .

# Expose server in the configured port
EXPOSE ${PORT}

# Install python dependencies
RUN pip install \
  -r requirements.txt \
  --no-cache-dir

WORKDIR ${WORKING_DIRECTORY}/app

# Run the main app server
CMD uvicorn main:app --host ${HOST} --port ${PORT}
