FROM golang:1.15
COPY . .
RUN go build -o ./server/server ./server/server-3.go
CMD ["./server/server"]
