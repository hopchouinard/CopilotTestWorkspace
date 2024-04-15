<#
.SYNOPSIS
    Generates customer data and saves it to a CSV file.

.DESCRIPTION
    The New-CustomerData function generates customer data based on the specified parameters and saves it to a CSV file.
    The function uses JSON files to load customer first names, last names, cities, and countries.
    The generated customer data includes CustomerID, FirstName, LastName, Email, Phone, City, and Country.

.PARAMETER filePath
    The path to the CSV file where the customer data will be saved. Default value is '.\CSV-Results\Customers.csv'.

.PARAMETER numCustomers
    The number of customers to generate. Must be a positive integer. Default value is 1000.

.EXAMPLE
    New-CustomerData -numCustomers 1000 -filePath '.\CSV-Results\Customers.csv'
    Generates 1000 customer records and saves them to the specified CSV file.

.NOTES
    This function requires the following JSON files to be present in the './json/' directory:
    - FirstNames.json: Contains a list of first names.
    - LastNames.json: Contains a list of last names.
    - Cities.json: Contains a list of cities.
    - Countries.json: Contains a list of countries.
    Author: Patrick Chouinard
    Date: 2024-04-15
#>
function New-CustomerData {
    param (
        [string]$filePath = '.\CSV-Results\Customers.csv',
        [ValidateRange(1, [int]::MaxValue)]
        [int]$numCustomers = 1000
    )

    $csvData = @()
    $csvData += 'CustomerID, FirstName, LastName, Email, Phone, City, Country'

    try {
        $FirstNames = Get-Content -Path $PSScriptRoot/json/FirstNames.json | ConvertFrom-Json
        $LastNames = Get-Content -Path $PSScriptRoot/json/LastNames.json | ConvertFrom-Json
        $Cities = Get-Content -Path $PSScriptRoot/json/Cities.json | ConvertFrom-Json
        $Countries = Get-Content -Path $PSScriptRoot/json/Countries.json | ConvertFrom-Json
    } catch {
        Write-Error "Failed to read or parse the JSON files: $_"
        return
    }

    for ($i = 1; $i -le $numCustomers; $i++) {
        try {
            $CustomerID = $i
            $FirstName = $FirstNames.firstNames[(Get-Random -Minimum 0 -Maximum $FirstNames.firstNames.count)]
            $LastName = $LastNames.lastNames[(Get-Random -Minimum 0 -Maximum $LastNames.lastNames.count)]
            $Email = "$FirstName.$LastName@$((Get-Random -Minimum 1000 -Maximum 9999)).com"
            $Phone = "+1 $((Get-Random -Minimum 100 -Maximum 999))-555-$((Get-Random -Minimum 1000 -Maximum 9999))"
            $City = $Cities.cities[(Get-Random -Minimum 0 -Maximum $Cities.cities.count)]
            $Country = $Countries.countries[(Get-Random -Minimum 0 -Maximum $Countries.countries.count)]
    
            $csvData += "$CustomerID, $FirstName, $LastName, $Email, $Phone, $City, $Country"
        } catch {
            Write-Error "An error occurred while generating customer data: $_"
        }
    }

    try {
        $csvData | Out-File -FilePath $filePath -Encoding utf8
    } catch {
        Write-Error "An error occurred while writing to the file: $_"
    }
}


