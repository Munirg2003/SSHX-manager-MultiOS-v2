# Release publishing checklist

Use this checklist before publishing a public release.

Pre-release validation
- [ ] PSScriptAnalyzer: no `Error` severity findings on main branch.
- [ ] Pester tests: all tests pass locally and in CI.
- [ ] Smoke test: full install flow validated in a clean Windows VM (Defender enabled).
- [ ] Verify AV consent flow and restoration behavior.
- [ ] Scheduled Task creation verified.

Artifact creation
- [ ] Build or collect `sshx-x86_64-pc-windows-msvc.zip`.
- [ ] Compute SHA256: `(Get-FileHash -Path <file> -Algorithm SHA256).Hash`.
- [ ] Create detached GPG signature: `gpg --armor --detach-sign <file>` (recommended).
- [ ] Optionally sign with Authenticode (signtool) if you have a code-signing cert.

Release publication
- [ ] Tag the release (e.g., `v6.0.0`) and push tag to origin.
- [ ] Create GitHub Release and attach artifacts (zip, .sig).
- [ ] Publish checksum and signature info in release notes.
- [ ] Update README with release SHA256 and verification instructions.

Post-release
- [ ] Perform one final smoke install by downloading release assets and installing on a fresh VM.
- [ ] Monitor issues / security reports and be prepared to publish hotfix release.
