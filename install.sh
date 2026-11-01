#!/bin/bash
# Install the undim-on-unlock user service. Usage: ./install.sh [OUTPUT]  (default DP-1)
set -euo pipefail
cd "$(dirname "$0")"
OUTPUT="${1:-DP-1}"
for cmd in kscreen-doctor dbus-monitor systemctl; do
    command -v "$cmd" >/dev/null || { echo "Missing: $cmd" >&2; exit 1; }
done
if ! kscreen-doctor -o 2>/dev/null | grep -q "Output: .* $OUTPUT "; then
    echo "Warning: output '$OUTPUT' not found in kscreen-doctor -o. Pass the right name as the first argument." >&2
fi
install -Dm755 undim-on-unlock ~/.local/bin/undim-on-unlock
install -d ~/.config/systemd/user
sed "s|undim-on-unlock DP-1|undim-on-unlock $OUTPUT|" undim-on-unlock.service > ~/.config/systemd/user/undim-on-unlock.service
systemctl --user daemon-reload
systemctl --user enable --now undim-on-unlock.service
systemctl --user --no-pager status undim-on-unlock.service | head -5
echo "Installed for output $OUTPUT."
