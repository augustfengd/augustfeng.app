package cmd

import (
	"bytes"
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/niklasfasching/go-org/org"
	"github.com/spf13/cobra"
)



func validate() {

}

func keywords(c *cobra.Command, args []string) {
	files := files(c)

	o := org.New()

	// var differences []string
	for _, file := range files {
		b, fError := os.ReadFile(file)
		if fError != nil {
			log.Fatal(fError)
		}

		r := bytes.NewReader(b)
		d := o.Parse(r, file)
		settings := make(map[string][]string)
		for K, v := range d.BufferSettings {
			k := strings.ToLower(K)
			settings[k] = strings.Fields(v)
		}
		fmt.Printf("%+v\n", settings)
	}
}
