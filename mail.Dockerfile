# base go image
FROM golang:1.21-alpine as builder

WORKDIR /app

COPY . /app/

RUN CGO_ENABLED=0 go build -o mail ./cmd/api

RUN chmod +x /app/mail

# build a tiny docker image
FROM alpine:latest 

RUN mkdir -p /app/templates

COPY --from=builder /app/mail /app
COPY --from=builder /app/templates /app/templates

WORKDIR /app
CMD ["./mail"]1