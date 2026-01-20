<#
PowerShell helper to initialize a git repository, create initial commit,
and optionally create & push to GitHub using the `gh` CLI.
Usage:
  powershell -ExecutionPolicy Bypass -File setup_repo.ps1
  powershell -ExecutionPolicy Bypass -File setup_repo.ps1 -repo "your-username/tetris-repo"
#>
param(
  [string]$repo = ""
)

function Abort($msg){ Write-Error $msg; exit 1 }

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { Abort "git not found. Install Git: https://git-scm.com/downloads" }

# initialize
if (-not (Test-Path .git)) {
  git init || Abort "git init failed"
}

git add . || Abort "git add failed"

try {
  git commit -m "Initial commit: add Tetris, README, LICENSE, manifest, favicon, CI" -q
} catch {
  Write-Output "No changes to commit or commit failed: $($_)"
}

# If gh CLI available, try to create repo and push
if (Get-Command gh -ErrorAction SilentlyContinue) {
  if ($repo -ne "") {
    gh repo create $repo --public --source=. --remote=origin --push || Write-Output "gh create failed; check authentication or create repo manually"
  } else {
    gh repo create --public --source=. --remote=origin --push || Write-Output "gh create failed; check authentication or create repo manually"
  }
} else {
  Write-Output "gh CLI not found. To publish manually, run the commands below (replace <your-username> and <repo>):"
  Write-Output "  git branch -M main"
  Write-Output "  git remote add origin https://github.com/<your-username>/<repo>.git"
  Write-Output "  git push -u origin main"
}

Write-Output "Done. If you used gh it attempted to create & push. Otherwise, push manually as instructed."