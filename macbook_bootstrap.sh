#!/bin/bash

# macbook_bootstrap.sh

set -e

echo "Installing XCode CLI tools..."
if ! xcode-select -p &> /dev/null; then
  xcode-select --install
  echo "Complete the XCode CLI setup in the pop-up window."
  echo "After installation completes, rerun this script."
  exit 0
else
  echo ""
fi

echo "Installing Homebrew..."
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ $(uname -m) == 'arm64' ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
 echo "Homebrew is already installed."
fi

echo "Installing Ansible..."
brew install ansible

echo "Bootstrap is complete!"
