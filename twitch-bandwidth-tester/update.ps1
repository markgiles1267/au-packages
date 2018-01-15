import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
	$URL32 = 'https://r-1.ch/TwitchTest.zip'
    Install-ChocolateyZipPackage 'twitch-bandwidth-tester' $URL32 "$env:TMP"
	
	@{
        URL32   = $URL32
        Version = (Get-Item "$env:TMP\TwitchTest.exe").VersionInfo.ProductVersion
    }
}

update