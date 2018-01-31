import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $version = curl https://api.github.com/repos/gammu/gammu/releases/latest | ConvertFrom-Json.tag_name
	
	@{
        URL32   = "https://dl.cihar.com/gammu/releases/windows/Gammu-$version-Windows.exe"
		URL64   = "https://dl.cihar.com/gammu/releases/windows/Gammu-$version-Windows-64bit.exe"
        Version = $version
    }
}

update