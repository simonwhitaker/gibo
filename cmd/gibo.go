package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

func init() {
	giboCmd.AddCommand(dumpCmd)
	giboCmd.AddCommand(listCmd)
	giboCmd.AddCommand(rootCmd)
	giboCmd.AddCommand(searchCmd)
	giboCmd.AddCommand(updateCmd)
	giboCmd.AddCommand(versionCmd)
}

var giboCmd = &cobra.Command{
	Use:   "gibo-go",
	Short: "gibo-go is a command-line tool for easily accessing gitignore boilerplates",
}

func Execute() {
	if err := giboCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
