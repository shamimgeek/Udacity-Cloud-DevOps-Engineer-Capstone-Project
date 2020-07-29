package main

import (
	"html/template"
	"log"
	"net/http"
	"os"
)

// PageData struct
type PageData struct {
	AppColor    string
	BuildNumber string
}

func handler(w http.ResponseWriter, r *http.Request) {
	appColor := "blue"
	buildNumber := "master"

	if c := os.Getenv("APP_COLOR"); c != "" {
		appColor = c
	}

	if b := os.Getenv("BUILD_NUMBER"); b != "" {
		buildNumber = b
	}

	tmpl := template.Must(template.ParseFiles("index.html"))

	data := PageData{
		AppColor:    appColor,
		BuildNumber: buildNumber,
	}
	tmpl.Execute(w, data)
}

func main() {
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe("0.0.0.0:80", nil))
}
