# GitHub Pages Deployment Guide

This repository is configured to automatically deploy the mdBook documentation to GitHub Pages.

## How it works

1. **GitHub Actions Workflow**: The `.github/workflows/pages.yml` workflow automatically:
   - Installs Rust and mdBook dependencies
   - Builds the documentation using mdBook
   - Deploys the built site to GitHub Pages

2. **Automatic Deployment**: Every push to the `main` branch triggers a new deployment.

## Manual Setup Steps

To enable GitHub Pages for this repository:

1. **Enable GitHub Pages**:
   - Go to your repository settings on GitHub
   - Navigate to "Pages" in the left sidebar
   - Under "Source", select "GitHub Actions"

2. **Repository Permissions**:
   - Go to Settings → Actions → General
   - Under "Workflow permissions", select "Read and write permissions"
   - Check "Allow GitHub Actions to create and approve pull requests"

## Local Development

To test the build locally:

### Option 1: Use the provided script
```bash
chmod +x build-local.sh
./build-local.sh
```

### Option 2: Manual build
```bash
# Install dependencies (requires Rust/Cargo)
cargo install mdbook --version 0.4.40
cargo install mdbook-tabs
cargo install mdbook-mermaid

# Build the book
mdbook build

# Serve locally for testing
mdbook serve
```

## Configuration

The documentation is configured in `book.toml`:
- **Title**: "Forge Docs"
- **Source**: `src/` directory
- **Output URL**: `https://digital-data-co.github.io/forge-docs`
- **Edit URL**: Links to GitHub for easy editing

## Features

- **Search**: Full-text search enabled
- **Tabs**: Tabbed content support via mdbook-tabs
- **Mermaid**: Diagram support via mdbook-mermaid
- **Custom CSS**: Custom styling in the `theme/` directory
- **Responsive**: Mobile-friendly design

## Troubleshooting

### Build Failures
- Check that all required dependencies are installed
- Ensure Rust/Cargo is properly installed
- Verify that the `src/` directory contains valid Markdown files

### GitHub Pages Issues
- Ensure GitHub Pages is enabled in repository settings
- Check that the workflow has proper permissions
- Verify the site URL in `book.toml` matches your GitHub Pages URL

### Local Development Issues
- Make sure Rust and Cargo are installed
- Check that all mdBook plugins are properly installed
- Verify the `book.toml` configuration is valid

## URL Structure

Once deployed, your documentation will be available at:
`https://digital-data-co.github.io/forge-docs`

Individual pages will follow the structure defined in `src/SUMMARY.md`.
