FROM golang:1.21 AS builder

WORKDIR /app

COPY main.go ./
COPY static ./static

RUN CGO_ENABLED=0 GOOS=linux go build -o /server main.go

FROM scratch

COPY --from=builder /server /server
COPY --from=builder /app/static /static

EXPOSE 4321

CMD ["/server"]
