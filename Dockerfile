# syntax=docker/dockerfile:1

FROM golang:1.20rc1-alpine3.17

# create a working directory inside the image
WORKDIR /app

# copy Go modules and dependencies to image
COPY go.mod ./

# download Go modules and dependencies
RUN go mod download

# copy directory files i.e all files ending with .go
COPY . ./

# compile application
RUN go build -o /github.com/murillomamud/api-go-postgres

# tells Docker that the container listens on specified network ports at runtime
EXPOSE 9000

# command to be used to execute when the image is used to start a container
CMD [ "/github.com/murillomamud/api-go-postgres" ]