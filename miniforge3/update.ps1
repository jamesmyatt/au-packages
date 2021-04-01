import-module au

$releases = 'https://github.com/conda-forge/miniforge/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)'.*'"       = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)'.*'"     = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*checksumType64\s*=\s*)'.*'" = "`$1'$($Latest.ChecksumType64)'"
          }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $url64   = $download_page.links | ? href -match 'Miniforge3-.*-Windows-x86_64\.exe$' | % href | select -First 1
    $version = (Split-Path ( Split-Path $url64 ) -Leaf) -replace '-', '.'

    @{
        URL64   = 'https://github.com' + $url64
        Version = $version
    }
}

update -ChecksumFor 64
