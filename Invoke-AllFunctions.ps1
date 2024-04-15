<#
.SYNOPSIS
    Invokes all PowerShell scripts in a specified directory.

.DESCRIPTION
    The Invoke-AllFunctions function retrieves all PowerShell scripts in a specified directory and executes them one by one, excluding the script itself (Load-AllFunctions.ps1).

.PARAMETER functionPath
    Specifies the path to the directory containing the PowerShell scripts. The default value is the current directory.

.EXAMPLE
    Invoke-AllFunctions -functionPath 'C:\Scripts'
    Invokes all PowerShell scripts in the 'C:\Scripts' directory.

.NOTES
    Author: Patrick Chouinard
    Date: 2024-04-15
#>

function Invoke-AllFunctions {
    param (
        [string]$functionPath = '.\'
    )

    try {
        $scripts = Get-ChildItem -Path $functionPath -Filter *.ps1
        if ($scripts.Count -eq 0) {
            Write-Error 'No PowerShell scripts found in the current directory.'
            return
        }
    } catch {
        Write-Error "An error occurred while retrieving the PowerShell scripts: $_"
    }

    foreach ($script in $scripts) {
        try {
            if ($script.Name -eq 'Invoke-AllFunctions.ps1') {
                continue
            } elseif ($script.Name -eq 'New-SampleData.ps1') {
                continue
            } else {
                . $script.FullName
            }
        } catch {
            Write-Error "An error occurred while executing the script: $_"
        }
    }
}

# Call the function
Invoke-AllFunctions