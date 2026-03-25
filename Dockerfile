FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copy the source code
COPY main.go .

# Build the Go app directly (without go.mod since it's a single file using standard library)
RUN CGO_ENABLED=0 GOOS=linux go build -o main main.go

# Use a lightweight alpine image for the final stage
FROM alpine:latest

WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/main .

EXPOSE 8080

CMD ["./main"]
