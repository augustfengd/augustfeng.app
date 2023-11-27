package cmd

import (
	"bufio"
	"log"
	"os"
	"path/filepath"
	"strings"

	"github.com/niklasfasching/go-org/org"
	"github.com/spf13/cobra"
)

func normalize(s string) string {
	a := strings.ToLower(s)
	b := strings.Replace(a, " ", "-", -1)
	c := strings.TrimSuffix(b, ".org")
	d := filepath.Base(c)
	return d
}

func compare(title string, path string) bool {
	a := normalize(title)
	b := normalize(path)
	return a == b
}

func titles(c *cobra.Command, args []string) error {
	files := files(c)
	o := org.New()

	var differences []string
	for _, file := range files {
		f, fError := os.Open(file)
		if fError != nil {
			return fError
		}
		r := bufio.NewReader(f)
		d := o.Parse(r, file)
		if title := d.Get("TITLE"); !compare(title, file) {
			differences = append(differences, file)
		}
	}

	if len(differences) > 0 {
		log.Fatalf("These files do not properly reflect the content's title: %s", differences)
	}

	return nil
}
