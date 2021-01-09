FROM golang:alpine as build_image
ENV GO111MODULE=on
RUN apk update --no-cache && apk add git
WORKDIR /app
ADD ./ /app
RUN go build -o golang-test .

FROM alpine
COPY --from=build_image /app/golang-test /app/golang-test
EXPOSE 8000
ENTRYPOINT ["/app/golang-test"]