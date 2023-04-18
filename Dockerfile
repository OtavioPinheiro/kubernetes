FROM golang:1.15
COPY . .
RUN go build -o server ./server
# RUN cd ./server && go build -o server .
# ENTRYPOINT ["chmod", "+x", "./server"]
CMD ["./server/server"]
