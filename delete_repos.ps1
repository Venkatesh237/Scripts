# 🔹 Replace with your GitHub username
USERNAME="venkatesh237"

# 🔹 Replace with your Personal Access Token (PAT) with "delete_repo" scope
TOKEN="ghp_s45ER1mespEPBTYiCA4LkQrVpV6xzB0KZ2j"

# Fetch repositories (first 100)
$repos = Invoke-RestMethod -Headers @{Authorization="token $TOKEN"} `
    -Uri "https://api.github.com/user/repos?per_page=100"

Write-Host "Found $($repos.Count) repositories:"
$repos | ForEach-Object { Write-Host $_.name }

$confirm = Read-Host "Type YES to delete all repositories"
if ($confirm -eq "YES") {
    foreach ($repo in $repos) {
        $repoName = $repo.name
        $url = "https://api.github.com/repos/$USERNAME/$repoName"
        try {
            Invoke-RestMethod -Headers @{Authorization="token $TOKEN"} `
                -Uri $url -Method Delete
            Write-Host "✅ Deleted $repoName"
        } catch {
            Write-Host "❌ Failed to delete $repoName"
        }
    }
} else {
    Write-Host "❌ Operation cancelled."
}
