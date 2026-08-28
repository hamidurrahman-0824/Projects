Product Analysis Dashboard — Power BI

A data analysis project using a synthetic product dataset. Data was cleaned inside Power Query and visualized using Power BI with custom DAX measures.

Tools Used
Power BI Desktop
Power Query (data cleaning)
DAX (custom measures)
Data Cleaning (Power Query)

Raw dataset had several quality issues that were resolved in Power Query:

Replaced "Unknown" category values with "Uncategorized"
Filled empty Stock values with "Upcoming"
Replaced null Discount values with 0
Set correct data types for Price, Rating, and Discount columns
Promoted first row to headers
DAX Measures Created
Average Price per Category — AVERAGEX across price column
Average Rating per Category — AVERAGEX across rating column
Total Product — COUNT of all products
In Stock / Out of Stock — CALCULATE with stock filter
Potential Revenue — SUMX for In Stock products only
Average Price After Discount — AVERAGEX with row level discount calculation
Rank by Discounted Price — RANKX across categories
Dashboard Preview

<img width="1539" height="1058" alt="Screenshot 2026-08-28 180204" src="https://github.com/user-attachments/assets/3288e06a-c452-425d-ac59-6c18c4669d3e" />
Key Findings
Stock is evenly distributed — In Stock (34%), Out of Stock (34%), Upcoming (31%) — no significant availability gap across products
Price has no correlation with rating — scatter plot shows completely random distribution, meaning higher priced products are not rated better
Average price is similar across all categories — Category B is slightly highest but differences are minimal
Average rating is nearly identical across categories — Category D is marginally highest, suggesting ratings are not category dependent

Author

Hamidur Rahman Majed Industrial & Production Engineering, SUST GitHub: hamidurrahman-0824
