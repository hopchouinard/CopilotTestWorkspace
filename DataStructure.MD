### Sample Data Structure for PowerBI

#### Tables:

1. **Sales**

   - SaleID (Primary Key)
   - ProductID (Foreign Key)
   - CustomerID (Foreign Key)
   - SaleDate
   - Quantity
   - SaleAmount

2. **Products**

   - ProductID (Primary Key)
   - ProductName
   - CategoryID (Foreign Key)
   - Price
   - StockQuantity

3. **Customers**

   - CustomerID (Primary Key)
   - FirstName
   - LastName
   - Email
   - Phone
   - City
   - Country

4. **Categories**
   - CategoryID (Primary Key)
   - CategoryName

#### Relationships:

- Sales to Products (Many-to-One)
- Sales to Customers (Many-to-One)
- Products to Categories (Many-to-One)

#### Data Types:

- **SaleDate**: Date/Time
- **Quantity, StockQuantity**: Whole Number
- **SaleAmount, Price**: Currency
- **Email**: Text
- **Phone**: Text (or Number if you prefer to remove formatting)
- **City, Country, FirstName, LastName, ProductName, CategoryName**: Text

#### Additional Features:

- **Calculated columns** in Sales, such as Profit = SaleAmount - (Quantity \* Product.Cost)
- **Measures** for total sales, average sale amount, total profit, etc.
- **Hierarchies** in Categories for drilling down from category to products.

### Hierarchies for Drill-Downs

#### Categories Table Hierarchy:

1. **CategoryName** (Top Level)
2. **SubCategoryName** (Second Level) - _Assuming there is a subcategory field_
3. **ProductID** (Third Level) - _Linked from the Products table_

#### Products Table Hierarchy:

1. **ProductName** (Top Level)
2. **Price Range** (Second Level) - _Create a calculated column that categorizes price into ranges like 'Budget', 'Mid-Range', 'Premium'_
3. **StockQuantity Status** (Third Level) - _Create a calculated column that categorizes stock quantity into 'Low', 'Medium', 'High'_

### Steps to Create Hierarchies in PowerBI:

1. In the **Fields** pane, right-click on the table name ('Categories' or 'Products').
2. Select **New hierarchy** to create a new hierarchy.
3. Drag the fields you want to include in your hierarchy into the hierarchy you just created.
4. Rename the hierarchy by right-clicking on it and selecting **Rename**.
5. Use these hierarchies in your reports to test the drill-down functionality.

### Calculated Columns and Measures for Testing DAX Formulas

#### Calculated Columns in 'Sales' Table:

1. **Profit**:

   - Formula: `Profit = SaleAmount - (Quantity * Related(Products[Cost]))`
   - Description: Calculates the profit for each sale.

2. **Year of Sale**:
   - Formula: `Year of Sale = YEAR(Sales[SaleDate])`
   - Description: Extracts the year from the sale date.

#### Measures:

1. **Total Sales**:

   - Formula: `Total Sales = SUM(Sales[SaleAmount])`
   - Description: Sums up all the sales amounts.

2. **Average Sale Amount**:

   - Formula: `Average Sale Amount = AVERAGE(Sales[SaleAmount])`
   - Description: Calculates the average amount of sales.

3. **Total Profit**:

   - Formula: `Total Profit = SUMX(Sales, Sales[Profit])`
   - Description: Sums up the profit from all sales.

4. **Product Count by Category**:

   - Formula: `Product Count by Category = CALCULATE(COUNTROWS(Products), ALLEXCEPT(Products, Products[CategoryID]))`
   - Description: Counts the number of products within each category.

5. **Sales YoY Growth**:
   - Formula: `Sales YoY Growth = (Total Sales - CALCULATE(Total Sales, SAMEPERIODLASTYEAR('Sales'[SaleDate]))) / CALCULATE(Total Sales, SAMEPERIODLASTYEAR('Sales'[SaleDate]))`
   - Description: Calculates the year-over-year growth of sales.

### Steps to Create Calculated Columns and Measures in PowerBI:

1. In the **Fields** pane, right-click on the table where you want to add a calculated column or measure.
2. Select **New column** for a calculated column or **New measure** for a measure.
3. Enter the DAX formula in the formula bar.
4. Name the calculated column or measure appropriately.
5. Use these in your reports to test the DAX formula functionality.
