Describe 'New-SalesData Tests' {
    Context 'When generating sales data' {
        It 'Should generate the correct number of sales' {
            # Arrange
            $numSales = 100
            $csvPath = '.\output\Sales1.csv'

            # Act
            New-SalesData -numSales $numSales -filePath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            $rowCount = $csvData.Count
            $expectedRowCount = $numSales
            $rowCount | Should Be $expectedRowCount
        }

        It 'Should generate valid data in each row' {
            # Arrange
            $numSales = 100
            $csvPath = '.\output\Sales2.csv'

            # Act
            New-SalesData -numSales $numSales -filePath $csvPath

            $Schema = @{
                SaleID     = [int]
                ProductID  = [int]
                CustomerID = [int]
                SalesDate  = [datetime]
                Quantity   = [int]
                SaleAmount = [int]
            }

            # Assert
            $csvData = Import-Csv -Path $csvPath | ForEach-Object {
                foreach ($property in $_.PSObject.Properties) {
                    $property.Value = $property.Value -as $Schema[$property.Name]
                }
                $_ # return the modified object
            }
            foreach ($row in $csvData) {
                $row.SaleID | Should BeOfType [int]
                $row.ProductID | Should BeOfType [int]
                $row.CustomerID | Should BeOfType [int]
                $row.SalesDate | Should BeOfType [datetime]
                $row.Quantity | Should BeOfType [int]
                $row.SaleAmount | Should BeOfType [int]
            }
        }
    }
}