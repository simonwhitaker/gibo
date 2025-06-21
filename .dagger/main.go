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

func (m *Gibo) Build(src *dagger.Directory,
	// +optional
	arch,
	// +optional
	os string) *dagger.File {
	return m.BuildEnv(src, arch, os).
		WithExec([]string{"go", "build", "-o", "gibo"}).
		File("/app/gibo")
}

func (m *Gibo) Test(ctx context.Context,
	src *dagger.Directory) (string, error) {
	return m.BuildEnv(src, "", "").
		WithExec([]string{"go", "test", "./..."}).
		Stdout(ctx)
}

func (m *Gibo) Vet(ctx context.Context,
	src *dagger.Directory) (string, error) {
	return m.BuildEnv(src, "", "").
		WithExec([]string{"go", "vet", "./..."}).
		Stdout(ctx)
}
