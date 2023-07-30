package cmd

import (
	"fmt"
	"log"

	"github.com/simonwhitaker/gibo-go/utils"
	"github.com/spf13/cobra"
)

var updateCmd = &cobra.Command{
	Use:   "update",
	Short: "Update the gitignore boilerplate repository",
	Run: func(cmd *cobra.Command, args []string) {
		msg, err := utils.Update()
		if err != nil {
			log.Fatal(err)
		} else {
			fmt.Println(msg)
		}
	},
}
