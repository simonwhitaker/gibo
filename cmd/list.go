package cmd

import (
	"fmt"
	"log"
	"os"

	"github.com/simonwhitaker/gibo-go/utils"
	"github.com/spf13/cobra"
	"golang.org/x/term"
)

var listCmd = &cobra.Command{
	Use:   "list",
	Short: "List available boilerplates",
	Run: func(cmd *cobra.Command, args []string) {
		list, err := utils.ListBoilerplates()
		if err != nil {
			log.Fatal(err)
		}
		if term.IsTerminal(int(os.Stdout.Fd())) {
			w, _, err := term.GetSize(int(os.Stdout.Fd()))
			if err == nil {
				utils.PrintInColumns(list, w)
				os.Exit(0)
			}
		}
		for _, el := range list {
			fmt.Println(el)
		}
	},
}
