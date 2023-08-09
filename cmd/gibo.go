package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var giboCmd = &cobra.Command{
	Use:   "gibo",
	Short: "gibo is a command-line tool for easily accessing gitignore boilerplates",
}

func Execute() {
	if err := giboCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
