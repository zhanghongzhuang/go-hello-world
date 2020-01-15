FROM golang  AS builder
RUN mkdir -p /golang-helloWorld
ADD golang-helloWorld/ /golang-helloWorld
WORKDIR /golang-helloWorld 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64  go build  -o app main.go
RUN ["chmod","+x","/golang-helloWorld/app"]


FROM alpine:latest
WORKDIR /app
COPY --from=builder /golang-helloWorld/app .
EXPOSE 8080
CMD ["./app"]
