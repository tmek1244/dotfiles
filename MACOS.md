# macOS setup

Run `install-macos.sh`, then work through the manual steps below. Karabiner
does most of the "make it feel like Linux" work, but a few macOS system
shortcuts take the keys first and have to be changed by hand.

## Before first launch

- **Stow before opening Karabiner-Elements.** `~/.config/karabiner` must not
  exist yet, so stow can make it a symlink to the whole directory. If
  Karabiner already created it: quit Karabiner, `rm -rf ~/.config/karabiner`,
  `stow karabiner`, then start it again.
- Karabiner asks for its **driver extension** and **Input Monitoring**
  permissions. Approve both in System Settings → Privacy & Security, or no
  rule will work.
- **Rectangle → Settings → General → tick "Launch on login".** It's off by
  default, so after a reboot the Win+arrow snapping does nothing until you start
  Rectangle by hand. (Karabiner runs as a background service and starts on its own.)
- Leave System Settings → Keyboard → Modifier Keys at the defaults. Karabiner
  already swaps the modifiers, and doing it in both places swaps them twice.

## System Settings → Keyboard → Keyboard Shortcuts

| Section | Shortcut | Change | Why |
|---|---|---|---|
| Input Sources | Select previous input source `⌃Space` | **Off** | zsh `autosuggest-accept` and Ctrl+Space in other apps |
| Input Sources | Select next source `⌃⌥Space` | **Off** | same |
| Mission Control | Mission Control `⌃↑` | Off (optional) | Karabiner already sends Ctrl+↑ to kitty as F18, so this can't take it |
| Mission Control | Application windows `⌃↓` | Off (optional) | same, via F19 |
| Mission Control | Move left a space `⌃←` | **Rebind to `⌃⌥⇧⌘←`**: record it by pressing **Win+Alt+←** | frees Ctrl+← in kitty; Karabiner sends this for the desktop shortcuts |
| Mission Control | Move right a space `⌃→` | **Rebind to `⌃⌥⇧⌘→`**: record it by pressing **Win+Alt+→** | frees Ctrl+→ in kitty; Karabiner sends this for the desktop shortcuts |
| Spotlight | Show Spotlight search `⌘Space` | **Keep** | Karabiner sends it when Win is tapped on its own |

When recording a shortcut, Karabiner is already changing your keys, so press the
shortcut you'll actually use (e.g. Win+Alt+←), not the keys printed in the table.
Pressing Ctrl+Alt+Shift+Win+← would record `⌥⇧⌘←`, because Ctrl turns into ⌘.

Also under Keyboard: turn on **"Use F1, F2, etc. keys as standard function
keys"** (kitty uses F1 to toggle the stack layout). In Karabiner's own
*Function Keys* tab you may also need to tick "Use all F1, F2, etc. keys as
standard function keys".

To switch keyboard layouts once `⌃Space` is off, use the Fn/🌐 key, or the
input menu in the menu bar.

## Shortcut map

The Karabiner rules apply to every keyboard: the PC keyboard, the MacBook's
built-in one, or anything else you plug in. They follow what's printed on the
keys:

| PC keyboard | MacBook keyboard | Acts as |
|---|---|---|
| Ctrl | control | **Ctrl**: sends `⌘` in apps (so Ctrl+C/V/T/W work as on Linux), real Ctrl inside kitty |
| Win | ⌘ command (either one) | **Super**: window snapping, lock, Spotlight on tap |
| Alt (left) | ⌥ option (left) | **Alt** in kitty (`macos_option_as_alt left`) |
| AltGr / Alt (right) | ⌥ option (right) | types ą/ę/ś |

MacBook keys that don't exist on its keyboard come from fn: fn+←/→ =
Home/End, fn+↑/↓ = PgUp/PgDn, fn+⌫ = Del.

### Turning it off for one keyboard

To make one keyboard plain macOS again (⌘C to copy and so on), for example the
laptop's, go to **Karabiner-Elements → Settings → Devices** and switch off
*Modify events* for that keyboard. Switch it back on to get the PC-style layout
again. Other keyboards aren't affected.

Karabiner saves the switch in `karabiner.json` (the device entry gets
`"ignore": true`), so it appears as a change in this repo. Commit it if you
want the setting kept, or `git checkout` the file to discard it.

| Keys | Does | Notes |
|---|---|---|
| Win (tapped alone) | Spotlight | apps, files, calculator; held with another key it is still ⌘ |
| Win+Alt (tapped together) | Mission Control | all windows; Win+Alt with an arrow still switches desktops |
| Win+L | Lock screen | sends `⌃⌘Q` |
| Win+H | Minimize | sends `⌘M` |
| Win+← / Win+→ | Left / right half | Rectangle (`⌃⌥←/→`); press again to cycle ½ → ⅔ → ⅓ |
| Win+↑ / Win+↓ | Top / bottom half | Rectangle (`⌃⌥↑/↓`), for the vertical monitor |
| Ctrl+Win+↑ | Maximize | Rectangle (`⌃⌥↩`) |
| Ctrl+Win+↓ | Restore previous size | Rectangle (`⌃⌥⌫`) |
| Shift+Win+← / → | Move window to the other monitor | Rectangle (`⌃⌥⌘←/→`) |
| Win+PgUp / Win+PgDn | Previous / next desktop | needs the Mission Control rebind above |
| Win+Alt+← / → | Previous / next desktop | same |
| Ctrl+Alt+← / → | Previous / next desktop | same |
| Ctrl+Alt+T | Open kitty | |
| Alt+F4 | Close window | sends `⌘W` |
| PrtSc | Screenshot tool | sends `⌘⇧5` |
| Home / End | Start / end of line | outside kitty |
| Ctrl+Home / Ctrl+End | Start / end of document | outside kitty |
| Ctrl+← / → | Previous / next word | outside kitty (in kitty: real Ctrl+arrows) |
| Ctrl+Backspace / Ctrl+Del | Delete word | outside kitty; kitty maps Ctrl+Backspace itself |
| Ctrl+Tab / Ctrl+Space | Stay Ctrl | for browser tabs etc. |
| Ctrl+↑ / Ctrl+↓ in kitty | History search by prefix | goes through F18/F19 so Mission Control can't catch it |
| Ctrl+Shift+C / Ctrl+Shift+V | Copy / paste in kitty | same as Linux; Ctrl+C in kitty is still interrupt (SIGINT) |

## Quick check after setup

- `kitten @ ls` in kitty prints JSON. If it does, remote control works, and so
  does Ctrl+h/j/k/l between nvim and kitty splits.
- Ctrl+↑ in zsh searches history instead of opening Mission Control.
- Tapping Win opens Spotlight; Win+← still snaps the window.
- `:Mason` in nvim shows no failed installs (they need node and python).
