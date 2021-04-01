$ErrorActionPreference = 'Stop'
$ToolsDir = Get-ToolsLocation
$pp = Get-PackageParameters

if (!$pp['InstallationType']) {
    $InstallationType = 'AllUsers'
}
else {
    if ($pp['InstallationType'] -notin 'AllUsers', 'JustMe') {
        Write-Error "Value for InstallationType not recognised: only `'AllUsers`' or `'JustMe`' are valid"
    }
    else {
        $InstallationType = $pp['InstallationType']
    }
}

if (!$pp['RegisterPython']) {
    $RegisterPython = '1'
}
else {
    if ($pp['RegisterPython'] -notin '0', '1') {
        Write-Error "Value for RegisterPython not recognised: only `'0`' or `'1`' are valid"
    }
    else {
        $RegisterPython = $pp['RegisterPython']
    }
}

if (!$pp['AddToPath']) {
    $AddToPath = '0'
}
else {
    if ($pp['AddToPath'] -notin '0', '1') {
        Write-Error "Value for AddToPath not recognised: only `'0`' or `'1`' are valid"
    }
    else {
        $AddToPath = $pp['AddToPath']
    }
}

if (!$pp['D']) {
    $D = Join-Path $ToolsDir 'miniforge3'
}
else {
    if (!(Test-Path -IsValid $pp['D'])) {
        Write-Error "Value for D ($($pp['D'])) is not a valid directory path"
    }
    else {
        $D = $pp['D']
    }
}

$packageArgs = @{
    packageName            = 'miniforge3'
    fileType               = 'exe'
    url64bit               = 'https://github.com/conda-forge/miniforge/releases/download/4.9.2-7/Miniforge3-4.9.2-7-Windows-x86_64.exe'
    checksum64             = 'c2c80a13087ee70f14fa7abdf45b4808567c6236062c63b1a9476b4fb911b778'
    checksumType64         = 'sha256'
    silentArgs             = "/S /InstallationType=$InstallationType /RegisterPython=$RegisterPython /AddToPath=$AddToPath /D=$D"
    validExitCodes         = @(0)
    softwareName           = 'miniforge3*'
  }

Install-ChocolateyPackage @packageArgs
