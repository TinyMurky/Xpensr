#!/usr/bin/env bash

# Reference:
# https://medium.com/@kevin.gamboa/how-to-configure-a-pre-commit-for-a-flutter-application-29dfbb853366
# This file copy ./pre-commit.bash into .git hook
# execute after flutter pub get

GIT_DIR=$(git rev-parse --git-dir)
HOOK_FILE="$GIT_DIR/hooks/pre-commit"

echo "Installing hooks..."

if [ -f scripts/pre-commit.bash ]; then
    ln -sf ../../scripts/pre-commit.bash $HOOK_FILE
    echo "Hooks installed successfully!"
else
    echo "Error: scripts/pre-commit.bash not found."
    exit 1
fi
