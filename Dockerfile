# Étape 1 : Build
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o main .

# Étape 2 : Image finale très légère (Alpine)
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/main .
# On expose le port 8080 (port utilisé par l'API dans l'exemple du hackathon)
EXPOSE 8080
CMD ["./main"]