package cmd

import (
	"log"

	"github.com/simonwhitaker/gibo/utils"
	"github.com/spf13/cobra"
)

var updateCmd = &cobra.Command{
	Use:   "update",
	Short: "Update the gitignore boilerplate repository",
	Run: func(cmd *cobra.Command, args []string) {
		if err := utils.Update(); err != nil {
			log.Fatal(err)
		}
	},
}
