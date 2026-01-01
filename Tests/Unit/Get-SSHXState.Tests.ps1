# Pester skeleton for Get-SSHXState
# Place under Tests/Unit
# Requires Pester v5+

Describe "Get-SSHXState" {
    BeforeAll {
        # Import the module or script to test if needed
        # . "$PSScriptRoot\..\..\sshx-functions.psm1"
    }

    It "returns default state when sshx.exe missing and no process" {
        Mock -CommandName Test-Path -MockWith { $false }
        Mock -CommandName Get-Process -MockWith { $null }
        $state = & { . "$PSScriptRoot\..\..\sshx-manager.ps1"; Get-SSHXState }  # adjust import as needed
        $state.IsInstalled | Should -BeFalse
        $state.IsRunning | Should -BeFalse
    }

    It "populates PIDs when process exists" {
        Mock -CommandName Test-Path -MockWith { $false }
        Mock -CommandName Get-Process -MockWith { @{Id=1234} }
        $state = Get-SSHXState
        $state.IsRunning | Should -BeTrue
        $state.PIDs | Should -Contain 1234
    }
}
