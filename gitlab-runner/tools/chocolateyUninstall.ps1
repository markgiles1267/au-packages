﻿$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

gsv gitlab-runner* | % {
    gitlab-runner.exe --log-level panic stop --service $_.Name
    gitlab-runner.exe --log-level panic uninstall --service $_.Name
}

$installDir = Get-RunnerInstallDir

Write-Warning 'If a gitlab-runner user is created during the installation, it is not removed as a safety measure'
Write-Warning '  to remove it execute: net user gitlab-runner /delete'
Write-Warning 'If Autologon parameter was used when installing, disable autolog manually'

# It might not be safe to just rm -Force -Recursive, let the user do it manually.
if ($installDir) {
    Write-Warning "Gitlab-runner remained installed in $installDir"
    Write-Warning "  to delete it execute: rm '$installDir' -Force -Recurse"
} else {
    Write-Warning "Can't find gitlab-runner installation directory, please remove it manually"
}