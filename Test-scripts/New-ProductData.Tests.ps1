Describe 'New-ProductData Tests' {
    Context 'When generating product data' {
        It 'Should generate the correct number of products' {
            # Arrange
            $numProducts = 100
            $csvPath = '.\output\Products1.csv'

            # Act
            New-ProductData -numProducts $numProducts -filePath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            $rowCount = $csvData.Count
            $expectedRowCount = $numProducts
            $rowCount | Should Be $expectedRowCount
        }

        It 'Should generate valid data in each row' {
            # Arrange
            $numProducts = 100
            $csvPath = '.\output\Products2.csv'

            # Act
            New-ProductData -numProducts $numProducts -filePath $csvPath

            $Schema = @{
                ProductID           = [int]
                ProductName         = [string]
                CategoryID          = [int]
                Price               = [int]
                PriceRange          = [string]
                StockQuantity       = [int]
                StockQuantityStatus = [string]
            }

            # Assert
            $csvData = Import-Csv -Path $csvPath | ForEach-Object {
                foreach ($property in $_.PSObject.Properties) {
                    $property.Value = $property.Value -as $Schema[$property.Name]
                }
                $_ # return the modified object
            }
            foreach ($row in $csvData) {
                $row.ProductID | Should BeOfType [int]
                $row.ProductName | Should BeOfType [string]
                $row.CategoryID | Should BeOfType [int]
                $row.Price | Should BeOfType [int]
                $row.PriceRange | Should BeOfType [string]
                $row.StockQuantity | Should BeOfType [int]
                $row.StockQuantityStatus | Should BeOfType [string]
            }
        }
    }
}