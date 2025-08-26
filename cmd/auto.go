package cmd

import (
	"fmt"
	"io/fs"
	"log"
	"path/filepath"
	"sort"
	"strings"

	"github.com/simonwhitaker/gibo/utils"
	"github.com/spf13/cobra"
)

func init() {
	giboCmd.AddCommand(autoCmd)
}

var autoCmd = &cobra.Command{
	Use:   "auto",
	Short: "Automatically detect languages and dump appropriate boilerplates",
	Long: `The auto command scans the current directory to detect programming languages
and frameworks in use, then outputs the appropriate .gitignore boilerplates.`,
	Run: func(cmd *cobra.Command, args []string) {
		// Get list of files in current directory
		files, err := scanDirectory(".")
		if err != nil {
			log.Fatalf("Error scanning directory: %v", err)
		}

		if len(files) == 0 {
			fmt.Println("No files found in current directory")
			return
		}

		// Get available boilerplates
		boilerplates, err := utils.ListBoilerplates()
		if err != nil {
			log.Fatalf("Error listing boilerplates: %v", err)
		}

		// Detect which boilerplates to use
		detected := detectBoilerplates(files, boilerplates)

		if len(detected) == 0 {
			fmt.Println("No matching boilerplates detected")
			return
		}

		// Dump the detected boilerplates
		for i, boilerplate := range detected {
			if i > 0 {
				fmt.Println() // Add blank line between boilerplates
			}
			if err := utils.PrintBoilerplate(boilerplate); err != nil {
				log.Printf("Warning: Could not dump %v: %v", boilerplate, err)
			}
		}
	},
}

// scanDirectory walks the directory tree and returns a list of file paths
func scanDirectory(root string) ([]string, error) {
	var files []string
	
	err := filepath.WalkDir(root, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}
		
		// Skip certain directories but not at root level
		if d.IsDir() && path != root {
			name := d.Name()
			// Skip .git, node_modules, and other common build/dependency directories
			if name == ".git" ||
			   name == "node_modules" || 
			   name == "vendor" || 
			   name == "target" || 
			   name == "build" || 
			   name == "dist" {
				return filepath.SkipDir
			}
			return nil
		}
		
		// Add all files (including hidden files for detection)
		if !d.IsDir() {
			files = append(files, path)
		}
		
		return nil
	})
	
	return files, err
}

// detectBoilerplates analyzes the file list and determines which boilerplates to use
func detectBoilerplates(files []string, availableBoilerplates []string) []string {
	// Create a map of file extensions and special files
	extensions := make(map[string]int)
	specialFiles := make(map[string]bool)
	
	for _, file := range files {
		base := filepath.Base(file)
		ext := filepath.Ext(file)
		
		// Track extensions
		if ext != "" {
			extensions[strings.ToLower(ext)]++
		}
		
		// Track special files that indicate specific technologies
		lowerBase := strings.ToLower(base)
		specialFiles[lowerBase] = true
	}
	
	// Map to track detected technologies
	detected := make(map[string]bool)
	
	// Check for programming languages by extension
	languageMap := map[string][]string{
		"Assembly":   {".asm", ".s"},
		"C":          {".c", ".h"},
		"C++":        {".cpp", ".cc", ".cxx", ".hpp", ".hh", ".hxx"},
		"CSharp":     {".cs"},
		"Clojure":    {".clj", ".cljs", ".cljc"},
		"Crystal":    {".cr"},
		"Dart":       {".dart"},
		"Elixir":     {".ex", ".exs"},
		"Fortran":    {".f", ".for", ".f90", ".f95"},
		"Go":         {".go"},
		"Haskell":    {".hs", ".lhs"},
		"Java":       {".java"},
		"Julia":      {".jl"},
		"Kotlin":     {".kt", ".kts"},
		"Lua":        {".lua"},
		"Matlab":     {".m"},
		"Nim":        {".nim"},
		"Node":       {".js", ".mjs", ".cjs", ".ts", ".tsx", ".jsx"},
		"PHP":        {".php"},
		"Perl":       {".pl", ".pm"},
		"Python":     {".py", ".pyw", ".pyx", ".pxd"},
		"R":          {".r", ".R"},
		"Ruby":       {".rb", ".rake"},
		"Rust":       {".rs"},
		"Scala":      {".scala"},
		"Swift":      {".swift"},
		"TeX":        {".tex", ".sty", ".cls"},
		"VHDL":       {".vhd", ".vhdl"},
		"Verilog":    {".v", ".vh"},
		"Zig":        {".zig"},
	}
	
	for lang, exts := range languageMap {
		for _, ext := range exts {
			if extensions[ext] > 0 {
				detected[lang] = true
				break
			}
		}
	}
	
	// Check for frameworks and tools by special files
	frameworkMap := map[string][]string{
		"Angular":       {"angular.json", ".angular-cli.json"},
		"Ansible":       {"ansible.cfg", "playbook.yml", "playbook.yaml"},
		"Autotools":     {"configure.ac", "makefile.am"},
		"Bazel":         {"build", "workspace"},
		"Buck":          {"buck", ".buckconfig"},
		"CMake":         {"cmakelists.txt"},
		"Carthage":      {"cartfile", "cartfile.resolved"},
		"CocoaPods":     {"podfile", "podfile.lock"},
		"Composer":      {"composer.json", "composer.lock"},
		"Django":        {"manage.py", "requirements.txt", "pipfile", "pipfile.lock"},
		"Dub":           {"dub.json", "dub.sdl"},
		"Elm":           {"elm.json", "elm-package.json"},
		"Flask":         {"app.py", "wsgi.py", "requirements.txt"},
		"Godot":         {"project.godot", ".godot"},
		"Gradle":        {"build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts"},
		"JetBrains":     {".idea"},
		"Laravel":       {"artisan", "composer.json"},
		"Leiningen":     {"project.clj"},
		"Maven":         {"pom.xml"},
		"Nim":           {"*.nimble"},
		"Node":          {"package.json", "package-lock.json", "yarn.lock", "pnpm-lock.yaml"},
		"Pub":           {"pubspec.yaml", "pubspec.lock"},
		"Qmake":         {".pro"},
		"ROS":           {"package.xml", "cmakelists.txt"},
		"Rails":         {"gemfile", "gemfile.lock", "rakefile"},
		"React":         {"package.json"}, // Will need to check content
		"Rebar":         {"rebar.config"},
		"SBT":           {"build.sbt"},
		"SCons":         {"sconstruct", "sconscript"},
		"Stack":         {"stack.yaml"},
		"Symfony":       {"symfony.lock", "composer.json"},
		"Terraform":     {"main.tf", "variables.tf", "outputs.tf"},
		"Unity":         {"projectsettings", "assets"},
		"UnrealEngine":  {".uproject"},
		"VSCode":        {".vscode"},
		"VisualStudio":  {".sln", ".csproj", ".vbproj", ".fsproj"},
		"Vue":           {"vue.config.js", "nuxt.config.js"},
		"Waf":           {"wscript"},
		"Xcode":         {".xcodeproj", ".xcworkspace"},
	}
	
	for framework, files := range frameworkMap {
		for _, file := range files {
			if strings.Contains(file, "*") {
				// Handle wildcard patterns
				pattern := strings.ReplaceAll(file, "*", "")
				for specialFile := range specialFiles {
					if strings.Contains(specialFile, pattern) {
						detected[framework] = true
						break
					}
				}
			} else if specialFiles[file] {
				detected[framework] = true
				break
			}
		}
	}
	
	// Special case: detect React by checking for react in package.json
	if specialFiles["package.json"] && !detected["React"] {
		// For now, we'll include React if Node is detected and package.json exists
		// In a real implementation, we'd parse package.json
		if detected["Node"] {
			// Don't add React separately as it's covered by Node
		}
	}
	
	// Check for operating systems (less common but available)
	if specialFiles["dockerfile"] || specialFiles["docker-compose.yml"] || specialFiles["docker-compose.yaml"] {
		detected["Docker"] = true
	}
	
	// Convert detected map to slice and filter against available boilerplates
	var result []string
	availableMap := make(map[string]bool)
	for _, bp := range availableBoilerplates {
		availableMap[strings.ToLower(bp)] = true
	}
	
	for tech := range detected {
		// Check exact match (case-insensitive)
		for _, bp := range availableBoilerplates {
			if strings.EqualFold(bp, tech) {
				result = append(result, bp)
				break
			}
		}
	}
	
	// Sort for consistent output
	sort.Strings(result)
	
	return result
}