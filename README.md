# macOS Setup Scripts

Automated setup scripts for configuring a new macOS machine with developer tools and productivity apps.

## Quick Start

```bash
# Run basic setup (installs Homebrew, apps, CLI tools)
./basic_setup.sh

# Setup SSH keys for GitHub and homelab
./ssh_keys_setup.sh

# Configure Finder settings
./finder_config.sh

# Apply zsh configuration
cp zsh_config.sh ~/.zshrc
source ~/.zshrc
```

## What Gets Installed

### Applications
- Google Chrome & Arc Browser
- Visual Studio Code
- Claude Code
- Notion & Slack
- Docker

### CLI Tools
- **fzf** - Fuzzy finder
- **zoxide** - Smart cd
- **tmux** - Terminal multiplexer
- **fd** - Modern find
- **htop/btop** - Process monitors
- **duf** - Disk usage
- **lsof** - List open files
- **jq** - JSON processor
- **tldr** - Simplified man pages
- **hyperfine** - Benchmarking tool
- **mise** - Version manager
- **awscli** - AWS command line
- **starship** - Prompt

---

# CLI Tools Mini Tutorials

## tmux - Terminal Multiplexer

Manage multiple terminal sessions in one window.

### Basic Commands
```bash
# Start new session
tmux

# Start named session
tmux new -s mysession

# List sessions
tmux ls

# Attach to session
tmux attach -t mysession

# Detach from session (inside tmux)
Ctrl+b, then d
```

### Key Bindings (Prefix: Ctrl+b)
```bash
# Split panes
Ctrl+b %          # Split vertically
Ctrl+b "          # Split horizontally

# Navigate panes
Ctrl+b arrow-key  # Move between panes

# Create/switch windows
Ctrl+b c          # Create new window
Ctrl+b n          # Next window
Ctrl+b p          # Previous window
Ctrl+b 0-9        # Switch to window number

# Resize panes
Ctrl+b :resize-pane -D 10  # Down
Ctrl+b :resize-pane -U 10  # Up
Ctrl+b :resize-pane -L 10  # Left
Ctrl+b :resize-pane -R 10  # Right
```

### Example Workflow
```bash
# Start coding session
tmux new -s dev

# Split for editor, terminal, and logs
Ctrl+b %    # Split vertically
Ctrl+b "    # Split horizontally

# Detach when done
Ctrl+b d

# Come back later
tmux attach -t dev
```

---

## fd - Modern Find Alternative

Faster, simpler file searching.

### Basic Usage
```bash
# Find files by name
fd filename

# Find files with extension
fd -e js
fd -e txt

# Find in specific directory
fd pattern /path/to/search

# Case-insensitive search
fd -i readme

# Include hidden files
fd -H config

# Exclude directories
fd -E node_modules -E .git
```

### Examples
```bash
# Find all JavaScript files
fd -e js

# Find all files modified today
fd -e js --changed-within 1d

# Find and execute command
fd -e txt -x cat {}

# Find files larger than 1MB
fd -S +1m

# Search only directories
fd -t d config

# Search only files
fd -t f test
```

### Combine with other tools
```bash
# Find and grep
fd -e js -x grep -l "import"

# Find and delete
fd -e tmp -x rm

# Count lines in all JS files
fd -e js -x wc -l | awk '{s+=$1} END {print s}'
```

---

## htop - Interactive Process Viewer

Better alternative to `top`.

### Basic Usage
```bash
# Launch htop
htop

# Launch with user filter
htop -u username
```

### Keyboard Shortcuts (Inside htop)
```bash
F1 or ?     # Help
F2          # Setup (customize display)
F3 or /     # Search process
F4 or \     # Filter processes
F5          # Tree view
F6          # Sort by column
F9          # Kill process
F10 or q    # Quit

Space       # Tag process
U           # Show processes for user
t           # Tree view
H           # Hide/show user threads
K           # Hide/show kernel threads

Arrows      # Navigate
+ / -       # Expand/collapse tree
```

### What to Look For
```bash
# High CPU usage (red bars)
# High memory usage (green bars)
# Load average (top right) - should be < number of CPU cores
# Swap usage - should be low
```

---

## btop - Resource Monitor

Beautiful, modern resource monitor.

### Basic Usage
```bash
# Launch btop
btop

# Launch with specific theme
btop --theme nord
```

### Keyboard Shortcuts
```bash
q           # Quit
m           # Toggle menu
Esc         # Close menu/dialog
+/-         # Increase/decrease update speed
arrows      # Navigate menus

# Process controls
k           # Kill process
t           # Terminate process
i           # Interrupt process

# View toggles
c           # Toggle CPU graph
m           # Toggle memory graph
n           # Toggle network graph
d           # Toggle disk graph
p           # Toggle processes

# Sorting (in process view)
p           # Sort by PID
n           # Sort by name
c           # Sort by CPU%
m           # Sort by memory%
```

### Tips
```bash
# Monitor specific process
# Launch btop, navigate to process list, use arrows

# Check disk I/O
# Press 'd' to focus on disk view

# Network monitoring
# Press 'n' to focus on network view
```

---

## tldr - Simplified Man Pages

Quick command examples instead of full manuals.

### Basic Usage
```bash
# Get examples for a command
tldr tar
tldr git
tldr ssh

# Update cache
tldr --update

# List all pages
tldr --list

# Search for command
tldr --search "archive"
```

### Examples
```bash
# Learn tar quickly
tldr tar
# Shows: create archive, extract, list contents, etc.

# Learn git commands
tldr git-commit
tldr git-rebase
tldr git-stash

# Learn Docker
tldr docker
tldr docker-compose

# System commands
tldr chmod
tldr chown
tldr rsync
```

### Why Use It?
```bash
# Instead of:
man tar  # (hundreds of lines)

# Use:
tldr tar  # (just the common examples)
```

---

## jq - JSON Processor

Parse, filter, and transform JSON from the command line.

### Basic Usage
```bash
# Pretty print JSON
echo '{"name":"John","age":30}' | jq .
curl api.example.com | jq .

# Extract field
echo '{"name":"John","age":30}' | jq '.name'
# Output: "John"

# Extract nested field
echo '{"user":{"name":"John"}}' | jq '.user.name'
# Output: "John"
```

### Array Operations
```bash
# Parse array
echo '[1,2,3,4,5]' | jq '.[]'
# Output: 1 2 3 4 5 (one per line)

# Filter array
echo '[1,2,3,4,5]' | jq '.[] | select(. > 2)'
# Output: 3 4 5

# Map over array
echo '[1,2,3]' | jq 'map(. * 2)'
# Output: [2,4,6]

# Get array length
echo '[1,2,3,4,5]' | jq 'length'
# Output: 5

# Get first/last element
echo '[1,2,3,4,5]' | jq '.[0]'   # First
echo '[1,2,3,4,5]' | jq '.[-1]'  # Last
```

### Real-World Examples
```bash
# Extract specific fields from API
curl https://api.github.com/users/octocat | jq '{name, location, public_repos}'

# Get all repo names
curl https://api.github.com/users/octocat/repos | jq '.[].name'

# Filter objects in array
echo '[{"name":"John","age":30},{"name":"Jane","age":25}]' | jq '.[] | select(.age > 26)'

# Create new JSON structure
echo '{"first":"John","last":"Doe"}' | jq '{fullName: (.first + " " + .last)}'

# Read from file
jq '.users[] | .name' data.json

# Combine with other commands
kubectl get pods -o json | jq '.items[] | {name: .metadata.name, status: .status.phase}'
```

### Useful Filters
```bash
# Keys of object
jq 'keys'

# Type of value
jq 'type'

# Sort array
jq 'sort'

# Unique values
jq 'unique'

# Group by field
jq 'group_by(.category)'
```

---

## hyperfine - Command Benchmarking

Accurately measure command execution time.

### Basic Usage
```bash
# Benchmark single command
hyperfine 'sleep 1'

# Compare multiple commands
hyperfine 'sleep 0.1' 'sleep 0.2'

# Benchmark with parameters
hyperfine --prepare 'make clean' 'make build'
```

### Advanced Options
```bash
# Set number of runs
hyperfine --runs 100 'my-command'

# Warmup runs (ignore first N runs)
hyperfine --warmup 3 'my-command'

# Set min/max runs
hyperfine --min-runs 10 --max-runs 100 'my-command'

# Export results
hyperfine --export-json results.json 'command1' 'command2'
hyperfine --export-markdown results.md 'command1' 'command2'
```

### Real-World Examples
```bash
# Compare grep vs ripgrep
hyperfine 'grep -r "pattern" .' 'rg "pattern"'

# Compare different algorithms
hyperfine 'python solution1.py' 'python solution2.py'

# Test with different parameters
hyperfine -P threads 1 8 'my-app --threads {threads}'

# Compare find vs fd
hyperfine 'find . -name "*.js"' 'fd -e js'

# Test Node.js vs Bun
hyperfine 'node script.js' 'bun script.js'

# Benchmark with setup/cleanup
hyperfine \
  --prepare 'sync; echo 3 | sudo tee /proc/sys/vm/drop_caches' \
  'cat large-file.txt > /dev/null'
```

### Example Output Interpretation
```bash
Benchmark 1: grep -r "pattern" .
  Time (mean ± σ):      1.234 s ±  0.045 s    [User: 0.890 s, System: 0.344 s]
  Range (min … max):    1.180 s …  1.320 s    10 runs

Benchmark 2: rg "pattern"
  Time (mean ± σ):     89.3 ms ±   3.2 ms    [User: 45.2 ms, System: 41.1 ms]
  Range (min … max):   84.5 ms …  95.8 ms    32 runs

Summary
  'rg "pattern"' ran
   13.82 ± 0.62 times faster than 'grep -r "pattern" .'
```

---

## lsof - List Open Files

See what files, network connections, and resources processes are using.

### Basic Usage
```bash
# List all open files
lsof

# Files opened by specific user
lsof -u username

# Files opened by specific process
lsof -p PID

# Files in specific directory
lsof +D /path/to/directory

# Who's using a specific file
lsof /path/to/file
```

### Network Connections
```bash
# All network connections
lsof -i

# Specific port
lsof -i :8080
lsof -i :3000

# Specific protocol
lsof -i tcp
lsof -i udp

# IPv4 only
lsof -i 4

# IPv6 only
lsof -i 6

# Connections to specific host
lsof -i @hostname

# TCP in LISTEN state
lsof -i tcp -s tcp:LISTEN
```

### Process Information
```bash
# Files opened by command name
lsof -c chrome
lsof -c node

# Combine user and command
lsof -u username -c node

# Exclude user
lsof -u ^root

# Files NOT opened by user
lsof -u ^username
```

### Common Use Cases
```bash
# Find what's using a port
lsof -i :8080

# Kill process using specific port
lsof -ti :8080 | xargs kill -9

# See all files a process is using
lsof -p $(pgrep -f "process-name")

# Find deleted files still held open (recover disk space)
lsof +L1

# Monitor file access in real-time
lsof -r 1 /path/to/file

# Check network connections for security
lsof -i -n -P

# Find which process has a file open (before unmounting)
lsof | grep /Volumes/USB

# See what files your terminal is using
lsof -p $$
```

### Useful Combinations
```bash
# Find and kill all processes using a directory
lsof +D /path | awk '{print $2}' | tail -n +2 | xargs kill -9

# See all listening ports with process names
lsof -i -P | grep LISTEN

# Find all network connections except localhost
lsof -i -n -P | grep -v "127.0.0.1\|localhost"

# Monitor Docker container file access
lsof -p $(docker inspect --format '{{.State.Pid}}' container_name)
```

### Output Columns
```bash
COMMAND   # Command name
PID       # Process ID
USER      # Process owner
FD        # File descriptor (cwd=current dir, txt=program text, mem=memory-mapped)
TYPE      # File type (REG=regular, DIR=directory, IPv4/IPv6=network)
DEVICE    # Device numbers
SIZE/OFF  # Size or offset
NODE      # Node number
NAME      # File name or network connection
```

---

## Additional Tips

### Combining Tools
```bash
# Find large files and examine with htop
fd -S +100m -x ls -lh | awk '{print $5, $9}'

# Find processes using lots of files
lsof -u username | wc -l

# Benchmark different search methods
hyperfine 'find . -name "*.js"' 'fd -e js'

# Parse JSON logs with jq and filter
tail -f app.log | jq 'select(.level == "error")'

# Use tldr to learn, then use the actual command
tldr rsync && rsync -avz source/ dest/
```

### Creating Aliases
Add to your `~/.zshrc`:
```bash
alias ports='lsof -i -P | grep LISTEN'
alias serve='python3 -m http.server'
alias myip='curl ifconfig.me'
alias cleanup='fd -H -t f ".DS_Store" -x rm'
```

---

## Resources

- [tmux cheatsheet](https://tmuxcheatsheet.com/)
- [fd GitHub](https://github.com/sharkdp/fd)
- [jq manual](https://stedolan.github.io/jq/manual/)
- [hyperfine GitHub](https://github.com/sharkdp/hyperfine)
- [tldr pages](https://tldr.sh/)

## Troubleshooting

**Issue**: Command not found after installation
**Solution**: Run `source ~/.zshrc` or restart your terminal

**Issue**: Homebrew not in PATH
**Solution**: Run `eval "$(/opt/homebrew/bin/brew shellenv)"` for Apple Silicon

**Issue**: Permission denied
**Solution**: Make scripts executable with `chmod +x script.sh`
