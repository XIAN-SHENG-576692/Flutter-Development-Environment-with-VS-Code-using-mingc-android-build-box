#!/bin/bash
# install_melos.sh
# Install Melos, then create a profile script under /etc/profile.d/ to add "$HOME/.pub-cache/bin" to your PATH.

set -e

# Install melos
dart pub global activate melos

# Create a profile script under /etc/profile.d/ to add "$HOME/.pub-cache/bin" to your PATH.
echo 'PATH="$PATH":"$HOME/.pub-cache/bin"' | sudo tee /etc/profile.d/add_pub_cache_bin_to_path.sh
sudo chmod +x /etc/profile.d/add_pub_cache_bin_to_path.sh
