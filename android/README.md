# SSHX on Android (Termux)

## Overview

Android does not allow traditional background services or system-wide installers without rooting the device. This project uses **Termux**, a user-space Linux environment, to run SSHX safely and transparently.

## Requirements

- Android device
- [Termux](https://f-droid.org/packages/com.termux/) installed from F-Droid
- Internet access

## Installation & Management

1. Open Termux.
2. Navigate to the `android/` directory.
3. Run the manager:
   ```bash
   chmod +x sshx-manager-termux.sh
   ./sshx-manager-termux.sh
   ```

## Key Features

- **TUI Management**: Interactive menu to install, start, and stop SSHX.
- **Root-less**: No root access required; runs entirely in user-space.
- **ASCII UI**: Clean, compatible interface for Termux.
- **Manual Control**: No hidden background persistence (aligned with Android security).

## Security Model

- User-consent driven.
- User-space only.
- No silent execution.
- No persistence (manual start required after Termux closes).
