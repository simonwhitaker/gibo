package cmd

import (
	"fmt"

	"github.com/simonwhitaker/gibo/utils"
	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "root",
	Short: "Show the directory where gibo stores its boilerplates",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(utils.RepoDir())
	},
}
