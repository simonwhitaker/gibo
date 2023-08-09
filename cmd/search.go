package cmd

import (
	"fmt"
	"io/fs"
	"log"
	"path/filepath"
	"strings"

	"github.com/simonwhitaker/gibo/utils"
	"github.com/spf13/cobra"
)

func init() {
	giboCmd.AddCommand(searchCmd)
}

var searchCmd = &cobra.Command{
	Use:   "search",
	Short: "Search for boilerplates",
	Args:  cobra.ExactArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		searchTerm := args[0]
		err := filepath.WalkDir(utils.RepoDir(), func(path string, d fs.DirEntry, err error) error {
			base := filepath.Base(path)
			ext := filepath.Ext(base)
			if ext == ".gitignore" {
				filename := strings.TrimSuffix(base, ext)
				if strings.Contains(strings.ToLower(filename), strings.ToLower(searchTerm)) {
					fmt.Println(filename)
				}
			}
			return nil
		})
		if err != nil {
			log.Fatal(err)
		}
	},
}
