Describe 'Create-SampleData Tests' {
    Context 'When creating sample data' {
        It 'Should generate the correct number of rows' {
            # Arrange
            $numEmployees = 10
            $csvPath = 'C:\path\to\output.csv'

            # Act
            Create-SampleData -numEmployees $numEmployees -csvPath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            $rowCount = $csvData.Count
            $expectedRowCount = $numEmployees + 1 # Account for the header row
            $rowCount | Should Be $expectedRowCount
        }

        It 'Should generate valid data in each row' {
            # Arrange
            $numEmployees = 10
            $csvPath = 'C:\path\to\output.csv'

            # Act
            Create-SampleData -numEmployees $numEmployees -csvPath $csvPath

            # Assert
            $csvData = Import-Csv -Path $csvPath
            foreach ($row in $csvData) {
                $row.ID | Should BeOfType [int]
                $row.FirstName | Should BeOfType [string]
                $row.LastName | Should BeOfType [string]
                $row.Age | Should BeOfType [int]
                $row.City | Should BeOfType [string]
                $row.Country | Should BeOfType [string]
                $row.Department | Should BeOfType [string]
            }
        }
    }
}