package cmd

import (
	"bufio"
	"fmt"
	"io"
	"log"
	"os"
	"path/filepath"
	"strings"

	"github.com/simonwhitaker/gibo/utils"
	"github.com/spf13/cobra"
	"golang.org/x/term"
)

const gitignoreFileName string = ".gitignore"

func init() {
	giboCmd.AddCommand(listIgnoreCmd)
}

var listIgnoreCmd = &cobra.Command{
	Use:   "list-ignore",
	Short: "List boilerplates in the .gitignore file",
	Run: func(cmd *cobra.Command, args []string) {
		list, err := findRegisteredBoilerplates(args)
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

func findRegisteredBoilerplates(args []string) ([]string, error) {
	if len(args) == 0 {
		return findBoilerplatesInGitignoreFile(filepath.Join(".", gitignoreFileName))
	}
	gitIgnorePath := args[0]
	if filepath.Base(gitIgnorePath) == gitignoreFileName {
		gitIgnorePath = filepath.Join(gitIgnorePath, gitignoreFileName)
	}
	return findBoilerplatesInGitignoreFile(gitIgnorePath)
}

func Exists(filename string) bool {
	_, err := os.Stat(filename)
	return err == nil
}

func findBoilerplatesInGitignoreFile(gitIgnoreFile string) ([]string, error) {
	if !Exists(gitIgnoreFile) {
		return []string{}, nil
	}
	in, err := os.Open(gitIgnoreFile)
	if err != nil {
		return nil, err
	}
	defer in.Close()

	var results []string
	reader := bufio.NewReader(in)
	for {
		line, _, err := reader.ReadLine()
		results = appendBoilerplateNameIfNeeded(results, string(line))
		if err == io.EOF {
			break
		}
		if err != nil {
			return nil, err
		}
	}
	return results, nil
}

func appendBoilerplateNameIfNeeded(results []string, line string) []string {
	if isBoilerplateName(line) {
		results = append(results, extractBoilerplateName(line))
	}
	return results
}

func extractBoilerplateName(line string) string {
	index := strings.LastIndex(line, "/")
	return strings.TrimSuffix(line[index+1:], ".gitignore")
}

func isBoilerplateName(line string) bool {
	return strings.HasPrefix(line, "###") && strings.HasSuffix(line, ".gitignore")
}
