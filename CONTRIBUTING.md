# Contributing

Thank you for your interest in contributing to SSHX-Manager.

Before you open a PR
- Ensure your change is small, atomic, and well-described.
- Run PSScriptAnalyzer and fix any errors flagged as `Severity: Error`.
  - Install: `Install-Module -Name PSScriptAnalyzer -Scope CurrentUser`
  - Run: `Invoke-ScriptAnalyzer -Path . -Recurse -Severity Error`
- Add or update Pester unit tests if your change touches logic.
  - Install: `Install-Module -Name Pester -Scope CurrentUser`
  - Run tests: `Invoke-Pester -Path Tests -EnableExit`

PR Checklist
- [ ] I have run PSScriptAnalyzer and addressed errors.
- [ ] I have added/updated Pester tests (Tests/Unit).
- [ ] I have updated CHANGELOG.md with an entry for this change.
- [ ] My PR includes testing instructions and any risky operations are documented.

Coding standards
- Use explicit error handling and log meaningful messages.
- Avoid destructive operations unless explicitly confirmed by flags.
- Respect `-DryRun` behavior in new commands and tests.
