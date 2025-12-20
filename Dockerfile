FROM golang:1.20-bookworm

WORKDIR /workspace

COPY my5G-RANTester my5G-RANTester/

RUN cd my5G-RANTester  \
    && go mod download 

# Move to the binary path
WORKDIR /workspace/my5G-RANTester/cmd

RUN go build -o app

# Install iperf
RUN apt update && \
    apt install -y iproute2 iperf iputils-ping && \
    rm -rf /var/lib/apt/lists/*
# Config files volume
VOLUME [ "/workspace/my5G-RANTester/config" ]
