package main

import (
	"context"
	"dagger/gibo/internal/dagger"
)

type Gibo struct{}

// Build a build-stage gibo image
func (m *Gibo) Build(src *dagger.Directory,
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
	return container.
		WithExec([]string{"go", "mod", "download"}).
		WithExec([]string{"go", "build", "-o", "gibo"})
}

// Build the gibo distribution image.
func (m *Gibo) Dist(ctx context.Context,
	src *dagger.Directory,
	// +optional
	arch,
	// +optional
	os string) *dagger.Container {
	builder := m.Build(src, arch, os)

	runImage := dag.Container().From("alpine").
		WithFile("/gibo", builder.File("/app/gibo")).
		WithExec([]string{"/gibo", "update"})

	return runImage.WithEntrypoint([]string{"/gibo"})
}

// Run the test suite for gibo.
func (m *Gibo) Test(ctx context.Context,
	src *dagger.Directory) (string, error) {
	return m.Build(src, "", "").
		WithExec([]string{"go", "test", "./..."}).
		Stdout(ctx)
}

// Run the vet tool for gibo.
func (m *Gibo) Vet(ctx context.Context,
	src *dagger.Directory) (string, error) {
	return m.Build(src, "", "").
		WithExec([]string{"go", "vet", "./..."}).
		Stdout(ctx)
}
