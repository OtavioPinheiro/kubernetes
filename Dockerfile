FROM golang:1.15
COPY . .
RUN go build -o ./new-server/server ./new-server
CMD ["./new-server/server"]
