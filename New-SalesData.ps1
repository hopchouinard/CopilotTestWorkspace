<#
.SYNOPSIS
    Generates sales data and saves it to a CSV file.

.DESCRIPTION
    The Create-SalesData function generates sales data based on the specified number of sales and saves it to a CSV file.
    The generated data includes sale ID, product ID, customer ID, sales date, quantity, and sale amount.

.PARAMETER numSales
    The number of sales to generate. The default value is 1000.

.PARAMETER filePath
    The file path where the generated sales data will be saved. The default value is "C:\Data\sales.csv".

.EXAMPLE
    Create-SalesData -numSales 1000 -filePath "C:\Data\sales_data.csv"
    Generates 500 sales records and saves them to the specified file path.

.OUTPUTS
    System.Object[]
    An array of strings representing the generated sales data.

    .NOTES
Author: Patrick Chouinard
Date: 2024-04-15
#>
function New-SalesData {
    param (
        [ValidateRange(1, [int]::MaxValue)]
        [int]$numSales = 1000,
        [string]$filePath = '.\CSV-Results\sales.csv'
    )

    try {
        $csvData = @()
        $csvData += 'SaleID, ProductID, CustomerID, SalesDate, Quantity, SaleAmount'

        for ($i = 1; $i -le $numSales; $i++) {
            $SaleID = $i
            $ProductID = Get-Random -Minimum 1 -Maximum $numSales
            $CustomerID = Get-Random -Minimum 1 -Maximum $numSales
            $SalesDate = Get-Date -Year 2024 -Month (Get-Random -Minimum 1 -Maximum 12) -Day (Get-Random -Minimum 1 -Maximum 28) -Format 'yyyy-MM-dd'
            $Quantity = Get-Random -Minimum 1 -Maximum 100
            $SaleAmount = Get-Random -Minimum 100 -Maximum 10000

            $csvData += "$SaleID, $ProductID, $CustomerID, $SalesDate, $Quantity, $SaleAmount"
        }

        # Create a CSV file with the generated data
        $csvData | Out-File -FilePath $filePath -Encoding utf8

        return $csvData
    } catch {
        Write-Host "An error occurred while generating sales data: $_"
    }
}

