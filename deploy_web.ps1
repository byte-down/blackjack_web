# 1. Recompile your code for the new repository path name
Write-Host "[INIT] Flutter Web Build..." -ForegroundColor Cyan
flutter build web --base-href "/blackjack_web/" --release

# 2. Jump into the generated build folder
Set-Location build/web

# 3. If this is the first run, initialize a separate Git environment here
if (-not (Test-Path .git)) {
    Write-Host "[Init] Local web git target..." -ForegroundColor Cyan
    git init -b main
    # CHANGE THE URL BELOW to match your new public repository link!
    git remote add origin https://github.com/byte-down/blackjack_web.git
}

# 4. Commit and push the raw HTML files straight up to the public repo
Write-Host "Staging and committing web artifacts..." -ForegroundColor Cyan
git add .
git commit -m "Automated deployment update"

Write-Host "[Push] Pushing directly to your public web repository..." -ForegroundColor Cyan
git push origin main --force

# 5. Jump back out to your main Flutter folder path
Set-Location ..\..

Write-Host "Deployment complete! Your live site will update in ~60 seconds." -ForegroundColor Green