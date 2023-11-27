package cmd

import (
	"io/fs"
	"log"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"github.com/spf13/cobra"
)

var root = &cobra.Command{
	Use: "lint",
}

func files(c *cobra.Command) []string {
	var ret []string

	directories, directoryFlagError := c.Flags().GetStringArray("directory")
	if directoryFlagError != nil {
		log.Fatal(directoryFlagError)
	}

	files, fileFlagError := c.Flags().GetStringArray("file")
	if fileFlagError != nil {
		log.Fatal(fileFlagError)
	}

	for _, it := range append(directories, files...) {
		filepath.Walk(it, func(path string, info fs.FileInfo, err error) error {
			if !info.IsDir() && strings.HasSuffix(info.Name(), ".org") {
				ret = append(ret, path)
			}
			return nil
		})
	}

	return ret
}

func configuration(c *cobra.Command) cue.Value {
	cc := cuecontext.New()

	file, err := c.Flags().GetString("configuration")
	if err != nil {
		log.Fatal(err)
	}

	b, err := os.ReadFile(file)
	if err != nil {
		log.Fatal(err)
	}

	return cc.CompileBytes(b)
}

func ConfigureFlags(c *cobra.Command) {
	c.PersistentFlags().String("configuration", "configuration.cue", "path to a lint configuration.")
	c.PersistentFlags().StringArray("directory", []string{}, "path to a content directory.")
	c.PersistentFlags().StringArray("file", []string{}, "path to a content file.")
}

func ConfigureCommands(c *cobra.Command) {
	c.AddCommand(&cobra.Command{Use: "keywords", Run: keywords})
	c.AddCommand(&cobra.Command{Use: "titles", RunE: titles})
	c.SetHelpCommand(&cobra.Command{Hidden: true})
	c.CompletionOptions.DisableDefaultCmd = true
}

func Execute() {
	ConfigureFlags(root)
	ConfigureCommands(root)
	if err := root.Execute(); err != nil {
		os.Exit(1)
	}
}
