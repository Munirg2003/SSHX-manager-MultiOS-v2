# SSHX-Manager — System Requirements (Multi-OS)

## Global Requirements

### Network & Connectivity
- **HTTPS internet connectivity** required to download the SSHX binary from `sshx.io`.
- **Firewall rules**: Outbound HTTPS (port 443) must be allowed.
- **No proxy restrictions** on `sshx.io` and GitHub URLs.

### Disk Space
- **Minimum 50 MB** free space for binary, logs, and state tracking.

---

## 🪟 Windows Requirements

### Operating System
- **Windows 10** (Version 1809 or later) or **Windows 11**.
- **Windows Server 2019** or later.

### PowerShell
- **PowerShell 5.1** (built-in) or **PowerShell 7.x**.
- Execution Policy: Must allow script execution (automatically handled by the manager).

### User Privileges
- **Administrator privileges** are required for:
  - Installing to `Program Files`.
  - Creating Scheduled Tasks.
  - Managing Windows Defender exclusions.

---

## 🐧 Linux Requirements

### Operating System
- Most modern distributions (Debian, Ubuntu, CentOS, Fedora, Arch).

### Dependencies
- `bash`, `curl`, `pgrep`, `pkill`.

### User Privileges
- **Root/Sudo** required for:
  - Installing to `/usr/local/bin`.
  - Managing processes.

---

## 🍎 macOS Requirements

### Operating System
- macOS 10.15 (Catalina) or later.

### Dependencies
- `zsh`, `curl`, `pgrep`, `pkill`.

### User Privileges
- **Sudo** required for:
  - Installing to `/usr/local/bin`.

---

## 🤖 Android (Termux) Requirements

### Environment
- [Termux](https://f-droid.org/packages/com.termux/) (installed from F-Droid, **not** Play Store).

### Dependencies
- `curl`, `openssh` (`pkg install curl openssh`).

### User Privileges
- **No root access required**. Runs entirely in user-space.

---

## Pre-Installation Checklist (Quick View)

| Platform | Command to Check |
|---|---|
| **Windows** | `powershell -ExecutionPolicy Bypass -File .\sshx-manager.ps1` |
| **Linux** | `sudo bash linux/sshx-manager.sh` |
| **macOS** | `sudo zsh macos/sshx-manager.zsh` |
| **Android** | `bash android/sshx-manager-termux.sh` |

---

## Support & Questions

If you encounter issues, please open an issue in the GitHub repository with:
- OS Version.
- Shell/PowerShell Version.
- Full error message or console output.
