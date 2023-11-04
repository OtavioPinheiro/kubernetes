FROM golang:1.15
COPY . .
RUN go build -o ./server/server ./server/server-5.go
CMD ["./server/server"]
