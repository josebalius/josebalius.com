# Dockerfile that runs main in a Go application

# Build the Go application
FROM golang:1.23 AS build
WORKDIR /app

# Install git
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/josebalius/thoughts .

# Copy dependencies and download them
RUN go mod download

# Copy the source code
COPY . .

# Build a statically linked binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app/main .

######################
# Prepare CA certificates
######################
FROM alpine:latest AS certs
RUN apk add --no-cache ca-certificates

# Run the Go application
FROM scratch
# Copy the binary from the build stage
COPY --from=build /app/main /app/main
# Copy the CA certificates from the Alpine stage
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Expose the port
EXPOSE 8080

ENTRYPOINT ["/app/main", "-repo=https://github.com/josebalius/josebalius.com"]

