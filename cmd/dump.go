package cmd

import (
	"log"

	"github.com/simonwhitaker/gibo/utils"
	"github.com/spf13/cobra"
)

func init() {
	giboCmd.AddCommand(dumpCmd)
}

var dumpCmd = &cobra.Command{
	Use:       "dump",
	Short:     "Dump one or more named boilerplates",
	Args:      cobra.MinimumNArgs(1),
	ValidArgs: utils.ListBoilerplatesNoError(),
	Run: func(cmd *cobra.Command, args []string) {
		for _, boilerplate := range args {
			if err := utils.PrintBoilerplate(boilerplate); err != nil {
				log.Fatalf("On dumping %v: %v", boilerplate, err)
			}
		}
	},
}
