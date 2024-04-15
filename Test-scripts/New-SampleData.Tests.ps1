Describe 'New-SampleData Tests' {
    Context 'When executing New-SampleData script' {

        It 'Should generate product data' {
            # Arrange
            $numProducts = 100
            $csvPath = '.\output\Products3.csv'

            # Act
            New-ProductData -numProducts $numProducts -filePath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            $rowCount = $csvData.Count
            $expectedRowCount = $numProducts
            $rowCount | Should Be $expectedRowCount
        }

        It 'Should generate customer data' {
            # Arrange
            $numCustomers = 1000
            $csvPath = '.\output\Customers3.csv'

            # Act
            New-CustomerData -numCustomers $numCustomers -filePath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            $rowCount = $csvData.Count
            $expectedRowCount = $numCustomers
            $rowCount | Should Be $expectedRowCount
        }

        It 'Should generate category data' {
            # Arrange
            $numCategories = 50
            $csvPath = '.\output\Categories3.csv'

            # Act
            New-CategoryData -numCategories $numCategories -filePath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            $rowCount = $csvData.Count
            $expectedRowCount = $numCategories
            $rowCount | Should Be $expectedRowCount
        }

        It 'Should generate sale data' {
            # Arrange
            $numSamples = 1000
            $csvPath = '.\output\Sales3.csv'

            # Act
            New-SalesData -numSamples $numSamples -filePath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            $rowCount = $csvData.Count
            $expectedRowCount = $numSamples
            $rowCount | Should Be $expectedRowCount
        }
    }
}