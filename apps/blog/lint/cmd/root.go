package cmd

import (
	"io/fs"
	"os"
	"path/filepath"
	"strings"

	"github.com/spf13/cobra"
)

var root = &cobra.Command{
	Use: "lint",
}

func files(c *cobra.Command) ([]string, error) {
	var ret []string

	directories, directoryFlagError := c.Flags().GetStringArray("directory")
	if directoryFlagError != nil {
		return nil, directoryFlagError
	}

	files, fileFlagError := c.Flags().GetStringArray("file")
	if fileFlagError != nil {
		return nil, fileFlagError
	}

	for _, directory := range append(directories, files...) {
		filepath.Walk(directory, func(path string, info fs.FileInfo, err error) error {
			if !info.IsDir() && strings.HasSuffix(info.Name(), ".org") {
				ret = append(ret, path)
			}
			return nil
		})
	}

	return ret, nil
}

func ConfigureFlags(c *cobra.Command) {
	c.PersistentFlags().StringArray("directory", []string{}, "path to a content directory")
	c.PersistentFlags().StringArray("file", []string{}, "path to a content file")
}

func ConfigureCommands(c *cobra.Command) {
	c.AddCommand(&cobra.Command{Use: "keywords", RunE: keywords})
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
