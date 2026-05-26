# 1. Ask you for a commit message so you can keep track of what you changed
$commitMessage = Read-Host -Prompt "Enter a description of your code changes"

# If you press Enter without typing anything, give it a default message
if ([string]::IsNullOrWhitespace($commitMessage)) {
    $commitMessage = "Code update: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
}

Write-Host "Staging code files..." -ForegroundColor Cyan
git add .

Write-Host "Saving commit locally..." -ForegroundColor Cyan
git commit -m $commitMessage

Write-Host "Pushing source code to private repository..." -ForegroundColor Cyan
git push origin main

Write-Host "Success! Your private repository is completely backed up." -ForegroundColor Green