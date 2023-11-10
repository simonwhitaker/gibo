package cmd

import (
	"log"
	"path/filepath"
	"strings"

	"github.com/simonwhitaker/gibo/utils"
	"github.com/spf13/cobra"
)

func init() {
	giboCmd.AddCommand(dumpCmd)
}

var dumpCmd = &cobra.Command{
	Use:       "dump",
	Short:     "Dump a boilerplate",
	Args:      cobra.MinimumNArgs(1),
	ValidArgs: utils.ListBoilerplatesNoError(),
	Run: func(cmd *cobra.Command, args []string) {
		if isAppendMode(args) {
			results, err := findBoilerplatesInGitignoreFile(filepath.Join(".", gitignoreFileName))
			if err != nil {
				log.Fatal(err.Error())
			}
			dumpBoilerplate(concatNames(results, args))
		} else {
			dumpBoilerplate(args)
		}
	},
}

func concatNames(results []string, args []string) []string {
	for _, arg := range args {
		if strings.HasPrefix(arg, "+") {
			results = append(results, arg[1:])
		} else {
			results = append(results, arg)
		}
	}
	return results
}

func isAppendMode(args []string) bool {
	for _, arg := range args {
		if strings.HasPrefix(arg, "+") {
			return true
		}
	}
	return false
}

func dumpBoilerplate(args []string) error {
	for _, boilerplate := range args {
		if err := utils.PrintBoilerplate(boilerplate); err != nil {
			log.Fatalf("On dumping %v: %v", boilerplate, err)
		}
	}
	return nil
}
