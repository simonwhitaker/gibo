package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Show the current version number of gibo",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("gibo v2.0")
	},
}
