package main

import (
	"context"
	"dagger/gibo/internal/dagger"
)

type Gibo struct{}

func (m *Gibo) BuildEnv(src *dagger.Directory) *dagger.Container {
	return dag.Container().
		From("golang:1.24.4-alpine").
		WithDirectory("/app", src).
		WithWorkdir("/app").
		WithEnvVariable("CGO_ENABLED", "0").
		// WithEnvVariable("GOOS", "darwin").
		// WithEnvVariable("GOARCH", "arm64").
		WithExec([]string{"go", "mod", "download"})
}

func (m *Gibo) Build(src *dagger.Directory) *dagger.File {
	return m.BuildEnv(src).
		// WithEnvVariable("GOOS", "darwin").
		// WithEnvVariable("GOARCH", "arm64").
		WithExec([]string{"go", "build", "-o", "gibo"}).
		File("/app/gibo")
}

func (m *Gibo) Test(ctx context.Context,
	src *dagger.Directory) (string, error) {
	return m.BuildEnv(src).
		WithExec([]string{"go", "test", "./..."}).
		Stdout(ctx)
}

func (m *Gibo) Vet(ctx context.Context,
	src *dagger.Directory) (string, error) {
	return m.BuildEnv(src).
		WithExec([]string{"go", "vet", "./..."}).
		Stdout(ctx)
}
