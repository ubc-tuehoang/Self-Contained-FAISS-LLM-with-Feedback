FROM ubuntu:latest

# Set environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHON_VERSION=3.8 

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    wget \
    gnupg \
    curl \
    software-properties-common \
    python${PYTHON_VERSION} \
    python3-pip \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#RUN python3 -m pip install --trusted-host pypi.python.org \
#    requests \
#    langchain \
#    pymilvus \
#    ollama \
#    pypdf \
#    langchainhub \
#    langchain-community \
#    langchain-experimental
    
# Set the working directory
WORKDIR /app

COPY . /app

ARG DOWNLOAD_URL="https://ollama.com/install.sh"

RUN wget $DOWNLOAD_URL -O install1.sh && \
    chmod +x install1.sh && \
    ./install1.sh

# Command to run when the container starts
CMD [ "echo", "Successfully installed!" ]


########
#> docker build -t drone_ai .
#> docker run -it drone_ai /bin/bash
#> docker run -it -p 11434:11434 drone_ai /bin/bash
#app> ollama serve &
#> OLLAMA_HOST=0.0.0.0 ollama serve &

### WAIT for about 10 seconds before <press enter>
#app> ollama list
#> <should be empty>

### PULL model: llava-llama3
#> ollama pull llava-llama3

#> ollama run llava-llama3 --verbose
#app> ollama run mistral --verbose
#> curl -X POST http://localhost:11434/api/generate -d '{  "model": "llama3",  "prompt":"What is water?"}'
#> curl -X POST http://localhost:11434/api/generate -d '{  "model": "mistral",  "prompt":"What is water?"}'

