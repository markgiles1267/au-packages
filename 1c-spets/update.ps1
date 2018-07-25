import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
	$headers = @{'Authorization' = "OAuth $env:YANDEX_DISK_TOKEN"}
	
    $release = curl 'https://cloud-api.yandex.net:443/v1/disk/resources?path=disk%3A%2F%D0%9F%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%2FSMT&fields=_embedded.items.sha256%2C_embedded.items.name&sort=-created' -Headers $headers | ConvertFrom-Json
	
	$file = ($release._embedded.items -match '_Spets.1cd')[0]
	
	@{
        URL32   = "https://cloud-api.yandex.net:443/v1/disk/resources/download?path=disk%3A%2F%D0%9F%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%2FSMT%2F$($file.name)&fields=href"
		Checksum32 = $file.sha256
		Checksum64 = $file.sha256
        Version = ($file.name -split '_')[0..2] -join '.'
		Options = @{'Headers' = $headers}
    }
}

update