# pull the golang image
FROM golang:1.21-alpine as build-dev

# Set the Env

ENV APP_NAME hello-world
ENV CMD_PATH main.go

# copy the application data into images
COPY . $GOPATH/src/$APP_NAME
WORKDIR $GOPATH/src/$APP_NAME

# Build the application

RUN CGO_ENABLED=0 go build -v -o /$APP_NAME $GOPATH/src/$APP_NAME/$CMD_PATH

# Run Stage
FROM alpine:3.14

# Set the env varaibale
ENV APP_NAME hello-world

# Copy only required data into image
COPY --from=build-dev /$APP_NAME .
 
# Expose application port
EXPOSE 8081
 
# Start app
CMD ./$APP_NAME

