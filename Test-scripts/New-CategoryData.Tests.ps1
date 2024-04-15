Describe 'New-CategoryData Tests' {
    Context 'When generating category data' {
        It 'Should generate the correct number of categories' {
            # Arrange
            $numCategories = 50
            $csvPath = '.\output\Categories1.csv'

            # Act
            New-CategoryData -numCategories $numCategories -filePath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            $rowCount = $csvData.Count
            $expectedRowCount = $numCategories
            $rowCount | Should Be $expectedRowCount
        }

        It 'Should generate valid data in each row' {
            # Arrange
            $numCategories = 50
            $csvPath = '.\output\Categories2.csv'

            # Act
            New-CategoryData -numCategories $numCategories -filePath $csvPath

            $Schema = @{
                CategoryID      = [int]
                CategoryName    = [string]
                SubCategoryName = [string]
                ProductID       = [int]
            }

            # Assert
            $csvData = Import-Csv -Path $csvPath | ForEach-Object {
                foreach ($property in $_.PSObject.Properties) {
                    $property.Value = $property.Value -as $Schema[$property.Name]
                }
                $_ # return the modified object
            }

            foreach ($row in $csvData) {
                $row.CategoryID | Should BeOfType [int]
                $row.CategoryName | Should BeOfType [string]
                $row.SubCategoryName | Should BeOfType [string]
                $row.ProductID | Should BeOfType [int]
            }
        }
    }
}