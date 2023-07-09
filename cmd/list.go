package cmd

import (
	"fmt"
	"log"

	"github.com/simonwhitaker/gibo/utils"
	"github.com/spf13/cobra"
)

var listCmd = &cobra.Command{
	Use:   "list",
	Short: "List available boilerplates",
	Run: func(cmd *cobra.Command, args []string) {
		list, err := utils.ListBoilerplates()
		if err != nil {
			log.Fatal(err)
		}
		for _, el := range list {
			fmt.Println(el)
		}
	},
}
