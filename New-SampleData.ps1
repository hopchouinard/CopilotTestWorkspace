<#
.SYNOPSIS
Executes all the scripts in the CopilotTestWorkspace folder and calls all the functions in the scripts.

.DESCRIPTION
This script retrieves all the PowerShell scripts in the CopilotTestWorkspace folder and executes them. It then calls specific functions in each script to generate sample data for products, customers, categories, and sales. If any errors occur during the execution or data generation, error messages are displayed.

.PARAMETER None

.EXAMPLE
.\New-SampleData.ps1

This example runs the script and generates sample data for products, customers, categories, and sales.

.NOTES
    Author: Patrick Chouinard
    Date: 2024-04-15
#>

try {
    $scripts = Get-ChildItem -Path $PSScriptRoot -Filter *.ps1
    if ($scripts.Count -eq 0) {
        Write-Error 'No PowerShell scripts found in the current directory.'
        return
    }
} catch {
    Write-Error "An error occurred while retrieving the PowerShell scripts: $_"
}

foreach ($script in $scripts) {
    try {
        if ($script.Name -eq 'New-SampleData.ps1') {
            continue
        } else {
            . $script.FullName
        }
        
    } catch {
        Write-Error "An error occurred while executing the script: $_"
    }
}

try {
    New-ProductData -numProducts 100 -filePath '.\CSV-Results\Products.csv'
} catch {
    Write-Error "An error occurred while generating product data: $_"
}

try {
    New-CustomerData -numCustomers 1000 -filePath '.\CSV-Results\Customers.csv'
} catch {
    Write-Error "An error occurred while generating customer data: $_"
}

try {
    New-CategoryData -numCategories 50 -filePath '.\CSV-Results\Categories.csv'
} catch {
    Write-Error "An error occurred while generating category data: $_"
}

try {
    New-SalesData -numSamples 1000 -filePath '.\CSV-Results\Sales.csv'
} catch {
    Write-Error "An error occurred while generating sale data: $_"
}
