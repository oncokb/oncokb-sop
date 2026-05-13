package main

import (
	"log"
	"net/http"
)

func main() {
	fs := http.FileServer(http.Dir("static"))

	http.Handle("/static/", http.StripPrefix("/static/", fs))

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// Tells the browser to check with server before using its cached version
		w.Header().Set("Cache-Control", "no-cache, must-revalidate")
		http.ServeFile(w, r, "static/index.html")
	})

	log.Println("Server running on http://localhost:4321")
	log.Fatal(http.ListenAndServe(":4321", nil))
}
