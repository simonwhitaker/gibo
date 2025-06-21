package main

import (
	"context"
	"dagger/gibo/internal/dagger"
)

type Gibo struct{}

func (m *Gibo) BuildEnv(src *dagger.Directory,
	// +optional
	arch,
	// +optional
	os string) *dagger.Container {
	container := dag.Container().
		From("golang:1.24.4-alpine").
		WithMountedDirectory("/app", src).
		WithWorkdir("/app").
		WithEnvVariable("CGO_ENABLED", "0")

	if arch != "" {
		container = container.WithEnvVariable("GOARCH", arch)
	}
	if os != "" {
		container = container.WithEnvVariable("GOOS", os)
	}
	return container.WithExec([]string{"go", "mod", "download"})
}

// Build the gibo Docker container image.
func (m *Gibo) Build(src *dagger.Directory,
	// +optional
	arch,
	// +optional
	os string) *dagger.Container {
	return m.BuildEnv(src, arch, os).
		WithExec([]string{"go", "build", "-o", "gibo"})
}

// Build the gibo binary. If arch and os are not specified, it will use the current platform's architecture and OS.
func (m *Gibo) BuildBinary(ctx context.Context,
	src *dagger.Directory,
	// +optional
	arch,
	// +optional
	os string) *dagger.File {
	return m.Build(src, arch, os).File("/app/gibo")
}

// Run the test suite for gibo.
func (m *Gibo) Test(ctx context.Context,
	src *dagger.Directory) (string, error) {
	return m.BuildEnv(src, "", "").
		WithExec([]string{"go", "test", "./..."}).
		Stdout(ctx)
}

// Run the vet tool for gibo.
func (m *Gibo) Vet(ctx context.Context,
	src *dagger.Directory) (string, error) {
	return m.BuildEnv(src, "", "").
		WithExec([]string{"go", "vet", "./..."}).
		Stdout(ctx)
}
