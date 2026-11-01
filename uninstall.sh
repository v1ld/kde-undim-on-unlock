#!/bin/bash
# Remove the undim-on-unlock user service.
set -uo pipefail
systemctl --user disable --now undim-on-unlock.service 2>/dev/null
rm -f ~/.local/bin/undim-on-unlock ~/.config/systemd/user/undim-on-unlock.service
systemctl --user daemon-reload
echo "Removed undim-on-unlock."
