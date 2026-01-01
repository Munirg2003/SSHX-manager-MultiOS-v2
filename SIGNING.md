# Signing release artifacts (GPG & Authenticode)

This file documents recommended signing options and how to configure CI to sign artifacts.

GPG (recommended, cross-platform)
1. Generate a GPG key (if you don''t have one):
   - `gpg --full-generate-key`
2. Export public key:
   - `gpg --armor --export yourkeyid > publickey.asc`
   - Publish `publickey.asc` in the repo or on your profile.
3. Create a detached ASCII-armored signature:
   - `gpg --armor --output artifact.zip.asc --detach-sign artifact.zip`
4. Verify locally:
   - `gpg --verify artifact.zip.asc artifact.zip`
5. CI:
   - Add `GPG_PRIVATE_KEY` and `GPG_PASSPHRASE` as repository secrets (GPG_PRIVATE_KEY should contain private key ASCII-armored block).
   - The release workflow imports the private key and runs `gpg --detach-sign`.

Authenticode (Windows / native)
1. Obtain a code-signing certificate (from a CA or internal PKI).
2. Sign with `signtool`:
   - `signtool sign /fd SHA256 /a /f yourcert.pfx /p <password> artifact.zip`
3. CI:
   - Store the PKCS#12 certificate (PFX) as a secret (`SIGNTOOL_PFX_BASE64`) and password `SIGNTOOL_PASSWORD`.
   - In CI decode and write the PFX to disk and invoke `signtool.exe`.
   - Note: Windows runners need `signtool.exe` available; include it or use a runner with Windows SDK.

CI secrets (recommended)
- GPG_PRIVATE_KEY: ASCII-armored private key
- GPG_PASSPHRASE: passphrase for the key
- SIGNTOOL_PFX_BASE64: base64-encoded PFX for code signing (optional)
- SIGNTOOL_PASSWORD: password for PFX

Security note
- Keep private keys secret. Use GitHub Actions secrets with restricted access.
- Rotate keys if leaked and publish revocation notices if necessary.
