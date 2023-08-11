package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

// These vars are populated at build time via the `-ldflags` configured in
// `.gorelease.yml`. More info at https://www.digitalocean.com/community/tutorials/using-ldflags-to-set-version-information-for-go-applications
var (
	version = "dev"
)

func init() {
	giboCmd.AddCommand(versionCmd)
}

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Show the current version number of gibo",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(version)
	},
}
