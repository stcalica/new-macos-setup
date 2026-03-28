#!/bin/bash
set -e  # Exit on error

echo "🔑 SSH Keys Setup Script"
echo "======================================"

# Create .ssh directory if it doesn't exist
SSH_DIR="$HOME/.ssh"
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Function to generate SSH key
generate_ssh_key() {
    local key_name=$1
    local key_comment=$2
    local key_path="$SSH_DIR/$key_name"

    if [ -f "$key_path" ]; then
        echo "⚠️  Key $key_name already exists. Skipping..."
        return
    fi

    echo "🔐 Generating SSH key: $key_name"
    ssh-keygen -t ed25519 -C "$key_comment" -f "$key_path" -N ""
    chmod 600 "$key_path"
    chmod 644 "$key_path.pub"
    echo "✓ Generated $key_name"
    echo ""
}

# Generate GitHub SSH key
echo "Setting up GitHub SSH key..."
generate_ssh_key "id_ed25519_github" "github-$(whoami)@$(hostname)"

# Generate Homelab SSH key
echo "Setting up Homelab SSH key..."
generate_ssh_key "id_ed25519_homelab" "homelab-$(whoami)@$(hostname)"

# Create or update SSH config
SSH_CONFIG="$SSH_DIR/config"
echo "📝 Configuring SSH config file..."

# Backup existing config if it exists
if [ -f "$SSH_CONFIG" ]; then
    cp "$SSH_CONFIG" "$SSH_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
    echo "✓ Backed up existing SSH config"
fi

# Create SSH config
cat > "$SSH_CONFIG" << 'EOF'
# GitHub Configuration
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github
    AddKeysToAgent yes
    UseKeychain yes

# Homelab Configuration
Host homelab
    HostName YOUR_HOMELAB_IP_OR_HOSTNAME
    User YOUR_USERNAME
    IdentityFile ~/.ssh/id_ed25519_homelab
    AddKeysToAgent yes
    UseKeychain yes

# Default settings for all hosts
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentitiesOnly yes
EOF

chmod 600 "$SSH_CONFIG"
echo "✓ SSH config created"
echo ""

# Add keys to ssh-agent
echo "🔓 Adding keys to ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain "$SSH_DIR/id_ed25519_github" 2>/dev/null || ssh-add "$SSH_DIR/id_ed25519_github"
ssh-add --apple-use-keychain "$SSH_DIR/id_ed25519_homelab" 2>/dev/null || ssh-add "$SSH_DIR/id_ed25519_homelab"
echo "✓ Keys added to ssh-agent"
echo ""

# Display public keys
echo "======================================"
echo "✅ SSH Keys Setup Complete!"
echo "======================================"
echo ""
echo "📋 Your GitHub public key (add this to GitHub → Settings → SSH Keys):"
echo "https://github.com/settings/keys"
echo ""
cat "$SSH_DIR/id_ed25519_github.pub"
echo ""
echo "---"
echo ""
echo "📋 Your Homelab public key:"
echo ""
cat "$SSH_DIR/id_ed25519_homelab.pub"
echo ""
echo "---"
echo ""
echo "⚙️  Next steps:"
echo "  1. Copy your GitHub public key above and add it to GitHub"
echo "  2. Copy your Homelab public key and add it to your homelab server"
echo "  3. Edit ~/.ssh/config and update YOUR_HOMELAB_IP_OR_HOSTNAME and YOUR_USERNAME"
echo "  4. Test GitHub connection: ssh -T git@github.com"
echo "  5. Test Homelab connection: ssh homelab"
echo ""

# Copy GitHub key to clipboard if pbcopy is available
if command -v pbcopy &> /dev/null; then
    cat "$SSH_DIR/id_ed25519_github.pub" | pbcopy
    echo "✓ GitHub public key copied to clipboard!"
    echo ""
fi
