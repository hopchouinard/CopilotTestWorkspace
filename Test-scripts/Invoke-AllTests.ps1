<#
.SYNOPSIS
    Invokes all PowerShell scripts in the specified directory.

.DESCRIPTION
    The Invoke-AllTests function is used to invoke all PowerShell scripts in the specified directory. It retrieves all the PowerShell scripts in the directory and executes them one by one, excluding the script itself (Execute-AllTests.ps1).

.PARAMETER TestPath
    Specifies the path to the directory containing the PowerShell scripts. By default, it is set to the Test-scripts folder in the same directory as the script.

.EXAMPLE
    Invoke-AllTests -TestPath "C:\Scripts"

    This example invokes all the PowerShell scripts in the "C:\Scripts" directory.

.INPUTS
    None. You cannot pipe objects to this function.

.OUTPUTS
    None. The function does not return any output.

.NOTES
    Author: Patrick Chouinard
    Date: 2024-04-15

#>

function Invoke-AllTests {
    param (
        [string]$TestPath = '.\'
    )

    try {
        $scripts = Get-ChildItem -Path $TestPath -Filter *.ps1
        if ($scripts.Count -eq 0) {
            Write-Error 'No PowerShell scripts found in the current directory.'
            return
        }
    } catch {
        Write-Error "An error occurred while retrieving the PowerShell scripts: $_"
    }

    foreach ($script in $scripts) {
        try {
            if ($script.Name -eq 'Invoke-AllTests.ps1') {
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
Invoke-AllTests