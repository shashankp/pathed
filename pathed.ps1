[CmdletBinding()]
Param (
    [string]$command = "check",
    [string]$path = (Get-Location),
    [string]$env = "machine"
)

$paths = [environment]::GetEnvironmentVariable("PATH").Split(";")
$validPaths = $paths | Where-Object {Test-Path $_}
$invalidPaths = $paths | Where-Object {-Not (Test-Path $_)}

switch ($command.ToLower())
{

    "check"{
        if ($validPaths.Contains($path)) {
            Write-Host "Current location IS present in PATH"
        } else {
            Write-Host "Current location IS NOT present in PATH"
        }
     }

    "add" {
        if ((Test-Path $path) -and (-Not ($validPaths.Contains($path)))) {
            $validPaths+=$path
            Write-Host "Added $path"
        }
     }

    "remove"{
        if ($validPaths.Contains($path)) {
            $validPaths=$validPaths -ne $path
            Write-Host "Removed $path"
        }
     }

    "clean"{
        if ($invalidPaths.Count -gt 0) {
            Write-Host "Removed following invalid path(s):"
            [String]::Join([environment]::NewLine, $invalidPaths)
        }
    }

    "print"{
        [String]::Join([environment]::NewLine, $validPaths)
    }

    default{
        Write-Host "Invalid command"
        break
    }
}

switch($env)
{
    "machine" {
        [environment]::SetEnvironmentVariable("PATH", [String]::Join(";", $validPaths), "Machine")
        [environment]::SetEnvironmentVariable("PATH", [String]::Join(";", $validPaths), "Process")
        [environment]::SetEnvironmentVariable("PATH", [String]::Join(";", $validPaths), "User")
    }

    "user" {
        [environment]::SetEnvironmentVariable("PATH", [String]::Join(";", $validPaths), "Process")
        [environment]::SetEnvironmentVariable("PATH", [String]::Join(";", $validPaths), "User")
    }

    default: {
        [environment]::SetEnvironmentVariable("PATH", [String]::Join(";", $validPaths), "Process")
    }
}
