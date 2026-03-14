#!/usr/bin/env bash

echo "Installing Agent OS..."

REPO="https://github.com/bvalerin/ai-agent-os"

TMP_DIR=$(mktemp -d)

git clone --depth=1 $REPO $TMP_DIR

cp -r $TMP_DIR/agent-os ./agent-os
cp -r $TMP_DIR/commands ./commands
cp -r $TMP_DIR/scripts ./scripts
cp -r $TMP_DIR/profiles ./profiles

# agregar variable al env
if [ -f ".env" ]; then
  if ! grep -q "AGENT_OS_PATH" .env; then
    echo "AGENT_OS_PATH=agent-os" >> .env
  fi
fi

rm -rf $TMP_DIR

echo "Agent OS installed successfully."