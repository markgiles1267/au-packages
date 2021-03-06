import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_BeforeUpdate() {
    rm 'tools\*.exe'
}

function global:au_GetLatest {
    $release = curl -UseBasicParsing "https://api.github.com/repos/ValdikSS/blockcheck/releases/latest?client_id=$env:GITHUB_CLIENT_ID&client_secret=$env:GITHUB_CLIENT_SECRET" | ConvertFrom-Json
	
	@{
        URL32   = ($release.assets | where {$_.name.EndsWith(".exe")}).browser_download_url
        Version = $release.tag_name
    }
}

update
