# Smart Orb™ — AutoScan & AutoFix (GitHub Actions)
This package adds three workflows to your repo:
- CodeQL Advanced — security analysis
- Appknox Scan — mobile/API security check
- Orb AutoFix — Smart Orb AI auto-repair for minor workflow errors

## Install
1. Download and unzip this package.
2. Copy the `.github/workflows/` folder into your repository root.
3. Commit and push to `main`.

## Secrets
Add in Settings → Secrets and variables → Actions:
- APPKNOX_TOKEN — your Appknox API token
- APPKNOX_APP_ID — your Appknox app id

## Notes
- Orb AutoFix runs after either workflow fails and attempts safe, common repairs.
- All changes are committed as smart-orb-bot with a clear message.
