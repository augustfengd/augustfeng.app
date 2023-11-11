package cmd

import (
	"bufio"
	"os"

	"github.com/niklasfasching/go-org/org"
	"github.com/spf13/cobra"
)

func keywords(c *cobra.Command, args []string) error {
	files, err := files(c)
	if err != nil {
		return err
	}

	o := org.New()

	for _, file := range files {
		f, fError := os.Open(file)
		if fError != nil {
			return fError
		}
		r := bufio.NewReader(f)
		d := o.Parse(r, file)

		var _ map[string][]string
		for k, v := range d.BufferSettings {
			println(k,v)
		}
	}
	return nil
}
