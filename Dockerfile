# Build the site and its embedded assets into one Go binary.
FROM golang:1.23 AS build
WORKDIR /app

COPY go.mod .
COPY main.go .
COPY public ./public

RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /app/main .

# The final image only needs the compiled Go server.
FROM scratch
COPY --from=build /app/main /app/main

EXPOSE 8080

ENTRYPOINT ["/app/main"]
