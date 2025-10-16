#!/bin/bash

# Build script for local testing of mdBook documentation
# This script installs required dependencies and builds the book

set -e

echo "Installing mdBook and dependencies..."

# Install mdBook
if ! command -v mdbook &> /dev/null; then
    echo "Installing mdbook..."
    cargo install mdbook --version 0.4.40
else
    echo "mdbook already installed"
fi

# Install mdbook-tabs
if ! command -v mdbook-tabs &> /dev/null; then
    echo "Installing mdbook-tabs..."
    cargo install mdbook-tabs
else
    echo "mdbook-tabs already installed"
fi

# Install mdbook-mermaid
if ! command -v mdbook-mermaid &> /dev/null; then
    echo "Installing mdbook-mermaid..."
    cargo install mdbook-mermaid
else
    echo "mdbook-mermaid already installed"
fi

echo "Building the book..."
mdbook build

echo "Build complete! The book is available in the 'book' directory."
echo "You can serve it locally with: mdbook serve"
