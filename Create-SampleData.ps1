#Create a sample CSV file with 1000 rows and 5 columns of data for testing purposes, the columns should be named: Name, Age, City, Country, Department
$numEmployees = 1000

$csvPath = 'C:\Users\Public\SampleData.csv'
$csvData = @()
$csvData += 'ID, FirstName, LastName, Age, City, Country, Department'

# Create a list of first names to be used in the data
$firstNames = @('John', 'Jane', 'Michael', 'Sarah', 'David', 'Emily', 'James', 'Emma', 'William', 'Olivia') 
# Create a list of last names to be used in the data
$lastNames = @('Smith', 'Johnson', 'Williams', 'Jones', 'Brown', 'Davis', 'Miller', 'Wilson', 'Moore', 'Taylor') 
# Create a list of cities to be used in the data
$cities = @('New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia', 'San Antonio', 'San Diego', 'Dallas', 'San Jose')
#Create a list of countries to be used in the data
$countries = @('USA', 'Canada', 'Mexico', 'Brazil', 'Argentina', 'Chile', 'UK', 'France', 'Germany', 'Italy')
#Create a list of departments to be used in the data
$departments = @('HR', 'Finance', 'IT', 'Marketing', 'Sales', 'Operations', 'Engineering', 'Customer Service', 'Legal', 'Administration')   


for ($i = 1; $i -le $numEmployees; $i++) {
    #Create an ID for each row
    $ID = $i
    #Select random value from the list of first names
    $firstName = $firstNames[(Get-Random -Minimum 0 -Maximum $firstNames.Count)]
    #Select random value from the list of last names
    $lastName = $lastNames[(Get-Random -Minimum 0 -Maximum $lastNames.Count)]
    #Generate a random age between 18 and 65
    $age = Get-Random -Minimum 18 -Maximum 65
    #Select random value from the list of cities
    $city = $cities[(Get-Random -Minimum 0 -Maximum $cities.Count)]
    #Select random value from the list of countries
    $country = $countries[(Get-Random -Minimum 0 -Maximum $countries.Count)]
    #Select random value from the list of departments
    $department = $departments[(Get-Random -Minimum 0 -Maximum $departments.Count)]

    #Add the data to the CSV array
    $csvData += "$ID, $firstName, $lastName, $age, $city, $country, $department"
}
$csvData | Out-File -FilePath $csvPath -Encoding utf8 -Force    

foreach ($row in $csvData) {
    Write-Output "Name: $($row.Name), Age: $($row.Age), City: $($row.City), Country: $($row.Country), Department: $($row.Department)"
}
