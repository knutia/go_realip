#Dockerfile References: https://docs.docker.com/engine/reference/builder/

# Start from the latest golang base image
FROM golang:latest AS builder

ENV PORT=8000
EXPOSE 8000
RUN mkdir /app 
ADD . /app/ 
WORKDIR /app

# Build the Go app
#RUN go build -o main .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .


######## Start a new stage from scratch #######
FROM alpine:latest  

ENV PORT=8000

# Expose port 8080 to the outside world
EXPOSE 8000

WORKDIR /root

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/main .

# Command to run the executable
CMD ["./main"] 