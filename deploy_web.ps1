Write-Host "Starting Flutter Web Build..." -ForegroundColor Cyan
flutter build web --base-href "/blackjack_web/" --release

Write-Host "Staging and committing web artifacts..." -ForegroundColor Cyan
git add build/web -f
git commit -m "Automated web deployment update"

Write-Host "Extracting web subtree..." -ForegroundColor Cyan
git subtree split --prefix build/web -b temp-web-branch

Write-Host "Force-pushing to GitHub Pages..." -ForegroundColor Cyan
git push https://github.com/byte-down/blackjack_web.git temp-web-branch:main --force

Write-Host "Cleaning up local temporary branch..." -ForegroundColor Cyan
git branch -D temp-web-branch

Write-Host "Deployment complete! Your live site will update in ~60 seconds." -ForegroundColor Green