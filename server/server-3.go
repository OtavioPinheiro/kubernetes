package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/configmap", ConfigMap)
	http.HandleFunc("/", Hello)
	http.ListenAndServe(":8000", nil)
}

func Hello(w http.ResponseWriter, r *http.Request) {
	name := os.Getenv("NAME")
	age := os.Getenv("AGE")
	w.Write([]byte("<h1>Full Cycle</h1>"))
	fmt.Fprintf(w, "Hello, I'm %s. I'm %s.", name, age)
}

func ConfigMap(w http.ResponseWriter, r *http.Request) {
	data, err := ioutil.ReadFile("/myfamily/family.txt")
	if err != nil {
		log.Fatalf("Erro ao ler o arquivo! Erro: ", err)
	}
	fmt.Fprintf(w, "My family: %s", string(data))
}
