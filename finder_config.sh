#!/bin/bash
set -e  # Exit on error

echo "🔍 Finder Configuration Script"
echo "======================================"

# Show hidden files in Finder
echo "📂 Showing hidden files in Finder..."
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
echo "📝 Showing all filename extensions..."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar in Finder
echo "📊 Showing status bar..."
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar in Finder
echo "🛤️  Showing path bar..."
defaults write com.apple.finder ShowPathbar -bool true

# Show hard drives on desktop
echo "💾 Showing hard drives on desktop..."
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

# Show external drives on desktop
echo "💿 Showing external drives on desktop..."
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Show removable media on desktop
echo "📀 Showing removable media on desktop..."
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show mounted servers on desktop
echo "🖥️  Showing mounted servers on desktop..."
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# Set default Finder view to list view
echo "📋 Setting default view to list view..."
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show Library folder
echo "📚 Showing Library folder..."
chflags nohidden ~/Library

# Show /Volumes folder
echo "📁 Showing /Volumes folder..."
sudo chflags nohidden /Volumes 2>/dev/null || echo "⚠️  Skipping /Volumes (requires sudo)"

# Configure sidebar items
echo "🔧 Configuring Finder sidebar..."

# Add user home directory to sidebar
defaults write com.apple.sidebarlists systemitems -dict-add ShowHardDisks -bool true
defaults write com.apple.sidebarlists systemitems -dict-add ShowEjectables -bool true
defaults write com.apple.sidebarlists systemitems -dict-add ShowRemovable -bool true

# Set Home as default location for new Finder windows
echo "🏠 Setting Home as default Finder location..."
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Disable the warning when changing a file extension
echo "⚠️  Disabling file extension change warning..."
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keep folders on top when sorting by name
echo "📌 Keeping folders on top..."
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Search the current folder by default
echo "🔎 Setting search scope to current folder..."
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable disk image verification
echo "💿 Disabling disk image verification..."
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
echo "🔄 Auto-opening windows for mounted volumes..."
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show item info near icons on the desktop and in other icon views
echo "ℹ️  Showing item info on desktop..."
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true

# Enable snap-to-grid for icons on the desktop and in other icon views
echo "📐 Enabling snap-to-grid..."
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true

# Restart Finder to apply changes
echo ""
echo "🔄 Restarting Finder to apply changes..."
killall Finder

echo ""
echo "======================================"
echo "✅ Finder Configuration Complete!"
echo "======================================"
echo ""
echo "Applied settings:"
echo "  ✓ Hidden files are now visible"
echo "  ✓ All file extensions are shown"
echo "  ✓ Hard drives shown on desktop"
echo "  ✓ External drives shown on desktop"
echo "  ✓ Removable media shown on desktop"
echo "  ✓ Status bar and path bar enabled"
echo "  ✓ Library folder is visible"
echo "  ✓ Folders kept on top when sorting"
echo "  ✓ Default view set to list view"
echo ""
echo "📝 Note: Some settings may require logging out and back in to fully apply."
echo ""
