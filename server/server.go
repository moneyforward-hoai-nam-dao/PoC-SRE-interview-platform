package main

import (
	"fmt"
	"net/http"
	"time"
)

func main() {
	http.HandleFunc("/", HelloWorld)
	http.ListenAndServe(":80", nil)
}

func HelloWorld(w http.ResponseWriter, r *http.Request) {
	// simulate  do something
	for i := 0; i < 1000; i++ {
		go func() {
			fmt.Println(time.Now().String())
		}()
	}

	// then return result
	w.WriteHeader(http.StatusOK)
}
