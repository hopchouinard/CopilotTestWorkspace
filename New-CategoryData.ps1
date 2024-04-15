<#
.SYNOPSIS
    Generates category data and saves it to a CSV file.

.DESCRIPTION
    The New-CategoryData function generates category data based on the specified parameters and saves it to a CSV file.
    The function reads a JSON file containing a list of category names and randomly selects names to assign to each category.
    The generated data is then saved to a CSV file with the specified file path.

.PARAMETER filePath
    The file path where the generated category data will be saved. The default value is '.\CSV-Results\Categories.csv'.

.PARAMETER numCategories
    The number of categories to generate. The default value is 50.

.EXAMPLE
    PS> New-CategoryData -numCategories 50 -filePath '.\CSV-Results\Categories.csv'
    Generates 20 categories and saves the data to the specified file path.

.INPUTS
    None.

.OUTPUTS
    System.Object[]

.NOTES
    Author: Patrick Chouinard
    Date: 2024-04-15
#>

function New-CategoryData {
    param (
        [string]$filePath = '.\CSV-Results\Categories.csv',
        [ValidateRange(1, [int]::MaxValue)]
        [int]$numCategories = 50
    )

    $csvData = @()
    $csvData += 'CategoryID, CategoryName, SubCategoryName, ProductID'

    try {
        $CategoryNames = Get-Content -Path $PSScriptRoot/json/CategoriesNames.json | ConvertFrom-Json
        $SubCategoryNames = Get-Content -Path $PSScriptRoot/json/SubCategoriesNames.json | ConvertFrom-Json
    } catch {
        Write-Error "Failed to read or parse the JSON files: $_"
        return
    }

    for ($i = 1; $i -le $numCategories; $i++) {
        try {
            $CategoryID = $i
            $CategoryName = $CategoryNames.Categories[(Get-Random -Minimum 0 -Maximum $CategoryNames.Categories.count )]
            $SubCategoryName = $SubCategoryNames.SubCategories[(Get-Random -Minimum 0 -Maximum $SubCategoryNames.SubCategories.count )]
            $ProductID = (Get-Random -Minimum 1 -Maximum 100)

            $csvData += "$CategoryID, $CategoryName, $SubCategoryName, $ProductID"
        } catch {
            Write-Error "An error occurred while generating category data: $_"
        }
    }

    try {
        $csvData | Out-File -FilePath $filePath -Encoding utf8
    } catch {
        Write-Error "An error occurred while writing to the file: $_"
    }

    return $csvData
}


