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
        if ($validPaths -Contains $path) {
            Write-Host "Path IS present in PATH"
        } else {
            Write-Host "Path IS NOT present in PATH"
        }
     }

    "append"{
        if ((Test-Path $path) -and (-Not ($validPaths -Contains $path))) {
            $validPaths+=$path
            Write-Host "Appended $path"
        } else {
            Write-Host "Did not append $path"
        }
     }

    "prepend"{
        if ((Test-Path $path) -and (-Not ($validPaths -Contains $path))) {
           $validPaths = $path + $validPaths
           Write-Host "Prepended $path"
        } else {
            Write-Host "Did not prepend $path"
        }
    }

    "remove"{
        if ($validPaths -Contains $path) {
            $validPaths=$validPaths -ne $path
            Write-Host "Removed $path"
        } else {
            Write-Host "Did not remove $path"
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

$validPaths = $validPaths | select -uniq

switch($env.ToLower())
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
