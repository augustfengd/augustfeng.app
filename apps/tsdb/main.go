package main

import (
	"context"
	"log"
	// "math"
	"time"

	"github.com/prometheus/prometheus/model/labels"
	"github.com/prometheus/prometheus/tsdb"
)

func main() {
	db, err := tsdb.Open("tsdb", nil, nil, nil, nil)
	if err != nil {
		log.Fatal(err)
	}

	app := db.Appender(context.Background())

	series := labels.FromStrings("__name__", "foobar", "foobar", "helloworld")
	_, err = app.Append(0, series, time.Now().UnixMilli(), 1)

	if err != app.Commit() {
		log.Fatal(err)
	}

	db.Close()
}
