FROM golang:1.15
COPY . .
RUN cd ./new-server && go build -o server
CMD [ "./server" ]
