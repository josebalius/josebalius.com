package main

import (
	"embed"
	"io/fs"
	"log"
	"net/http"
)

// siteFiles is compiled into the server so the final container has no runtime
// dependency on a separate web server or source repository.
//go:embed public
var siteFiles embed.FS

func main() {
	publicFS, err := fs.Sub(siteFiles, "public")
	if err != nil {
		log.Fatal(err)
	}

	server := &http.Server{
		Addr:    ":8080",
		Handler: http.FileServer(http.FS(publicFS)),
	}

	log.Printf("serving embedded site on %s", server.Addr)
	log.Fatal(server.ListenAndServe())
}
