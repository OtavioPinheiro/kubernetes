FROM golang:1.15
COPY . .
RUN go build -o ./server/server ./server/server-4.go
CMD ["./server/server"]
