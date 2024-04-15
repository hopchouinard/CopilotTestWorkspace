Describe 'New-CustomerData Tests' {
    Context 'When generating customer data' {
        It 'Should generate the correct number of customers' {
            # Arrange
            $numCustomers = 100
            $csvPath = '.\output\Customers1.csv'

            # Act
            New-CustomerData -numCustomers $numCustomers -filePath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            $rowCount = $csvData.Count
            $expectedRowCount = $numCustomers
            $rowCount | Should Be $expectedRowCount
        }

        It 'Should generate valid data in each row' {
            # Arrange
            $numCustomers = 100
            $csvPath = '.\output\Customers2.csv'

            # Act
            New-CustomerData -numCustomers $numCustomers -filePath $csvPath
            
            $Schema = @{
                CustomerID = [int]
                FirstName  = [string]
                LastName   = [string]
                Email      = [string]
                Phone      = [string]
                City       = [string]
                Country    = [string]
            }

            # Assert
            $csvData = Import-Csv -Path $csvPath | ForEach-Object {
                foreach ($property in $_.PSObject.Properties) {
                    $property.Value = $property.Value -as $Schema[$property.Name]
                }
                $_ # return the modified object
            }
            foreach ($row in $csvData) {
                $row.CustomerID | Should BeOfType [int]
                $row.FirstName | Should BeOfType [string]
                $row.LastName | Should BeOfType [string]
                $row.Email | Should Match '\w+@\w+\.\w+'
                $row.Phone | Should Match '\+\d{1,2} \d{3}-\d{3}-\d{4}'
                $row.City | Should BeOfType [string]
                $row.Country | Should BeOfType [string]
            }
        }
    }
}