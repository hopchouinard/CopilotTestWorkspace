<#
.SYNOPSIS
Generates product data and saves it to a CSV file.

.DESCRIPTION
The New-ProductData function generates product data based on the specified number of products and saves it to a CSV file. The generated data includes product IDs, product names, category IDs, prices, and stock quantities.

.PARAMETER numProducts
Specifies the number of products to generate. The value must be between 1 and the maximum value of an integer.

.PARAMETER filePath
Specifies the file path where the generated data will be saved as a CSV file.

.EXAMPLE
New-ProductData -numProducts 100 -filePath "C:\Data\Products.csv"
Generates 100 products and saves the data to the "C:\Data\Products.csv" file.

.INPUTS
None.

.OUTPUTS
None.

.NOTES
Author: Patrick Chouinard
Date: 2024-04-15
#>

function New-ProductData {
    param (
        [ValidateRange(1, [int]::MaxValue)]
        [int]$numProducts = 100,
        [string]$filePath = '.\CSV-Results\Customers.csv'
    )

    try {
        $csvData = @()
        $csvData += 'ProductID, ProductName, CategoryID, Price, PriceRange, StockQuantity, StockQuantityStatus'

        try {
            $ProductNames = Get-Content -Path $PSScriptRoot/json/ProductNames.json | ConvertFrom-Json
            $PriceRanges = @('Budget', 'Mid-Range', 'Premium')
            $StockQuantityStatuses = @('Low', 'Medium', 'High')
        } catch {
            Write-Error "Failed to read or parse the ProductNames.json file: $_"
            return
        }

        for ($i = 1; $i -le $numProducts; $i++) {
            $ProductID = $i
            $ProductName = $ProductNames.products[(Get-Random -Minimum 0 -Maximum $ProductNames.products.count)]
            $CategoryID = Get-Random -Minimum 1 -Maximum 50
            $Price = Get-Random -Minimum 10 -Maximum 10000
            #Get the value for Price Range based on the Price value
            $PriceRange = if ($Price -lt 1000) { $PriceRanges[0] } elseif ($Price -lt 5000) { $PriceRanges[1] } else { $PriceRanges[2] }
            $StockQuantity = Get-Random -Minimum 1 -Maximum 1000
            #Get the value for Stock Quantity Status based on the Stock Quantity value
            $StockQuantityStatus = if ($StockQuantity -lt 100) { $StockQuantityStatuses[0] } elseif ($StockQuantity -lt 500) { $StockQuantityStatuses[1] } else { $StockQuantityStatuses[2] }

            $csvData += "$ProductID, $ProductName, $CategoryID, $Price, $PriceRange, $StockQuantity, $StockQuantityStatus"
        }

        $csvData | Out-File -FilePath $filePath -Encoding utf8

        return $csvData
    } catch {
        Write-Error "An error occurred while generating product data: $_"
    }
}

