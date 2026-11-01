# Undim on unlock

A workaround for [KDE bug 513809](https://bugs.kde.org/show_bug.cgi?id=513809). After the screen wakes, PowerDevil sometimes leaves KWin's output dimming at 30%. `kscreen-doctor -o` then shows "dimming to 30%" while brightness is still 100%. The bug is confirmed and still open on Plasma 6.8. A fix went into 6.6.5 but didn't cover every case, and the later fix attempts were reverted or never merged.

On every unlock, this watcher waits 3 seconds. If dimming is still below 100% by then, it resets dimming to 100% and logs a line to the journal.

## Fix it right now

    kscreen-doctor output.DP-1.dimming.100

Don't rely on restarting `plasma-powerdevil`. In the bug reports, a restart sometimes applied the 30% dim again instead of clearing it.

## Install

    unzip undim-on-unlock.zip && cd undim-on-unlock
    ./install.sh          # or ./install.sh <output> if yours isn't DP-1

This puts the script in `~/.local/bin/` and the unit in `~/.config/systemd/user/`, then enables and starts the service.

## Check it worked

    systemctl --user status undim-on-unlock
    journalctl --user -t undim-on-unlock

A journal line appears each time it had to fix a stuck dim.

## Remove it once KDE fixes the bug

    ./uninstall.sh

## Without the script

Turn off "Dim screen" in System Settings → Power Management. The screen still turns off when idle, which is what matters most for burn-in.
