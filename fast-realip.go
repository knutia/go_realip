package main

import (
    "log"
    "fmt"
    "os"
    "github.com/valyala/fasthttp"
    "github.com/ferluci/fast-realip"
)

func main() {
    if err := fasthttp.ListenAndServe(":8080", realipHandler); err != nil {
        log.Fatalf("Error in ListenAndServe: %s", err)
    }
}

func realipHandler(ctx *fasthttp.RequestCtx) {
    clientIP := realip.FromRequest(ctx)
    log.Println("GET / from", clientIP)
    host := os.Getenv("HOSTNAME")
    fmt.Fprint(ctx, "Hello "+clientIP+" ! Your request was processed by "+host+".")
}

