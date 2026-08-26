/*
Bronze Layer Data Loading

- Ingest raw CRM and ERP data from source CSV files into Bronze tables.
- Create a stored procedure to automate the Bronze layer loading process.
- Truncate existing Bronze tables before performing a full reload.
- Use BULK INSERT to load source data into SQL Server.
- Preserve raw source data before cleaning and transformation in the Silver layer.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN

 BEGIN TRY

TRUNCATE TABLE bronze.crm_customer_info
BULK INSERT bronze.crm_customer_info
from 'C:\Users\eneng\Documents\Retail_Portfolio_Project\DataWareHouse\Datasets\crm\crm_customer_info.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock);

TRUNCATE TABLE bronze.crm_customer_address
BULK INSERT bronze.crm_customer_address
from 'C:\Users\eneng\Documents\Retail_Portfolio_Project\DataWareHouse\Datasets\crm\crm_customer_address.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock);

TRUNCATE TABLE bronze.crm_sales_order_lines
BULK INSERT bronze.crm_sales_order_lines
from 'C:\Users\eneng\Documents\Retail_Portfolio_Project\DataWareHouse\Datasets\crm\crm_sales_order_lines.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock);

TRUNCATE TABLE bronze.crm_sales_orders
BULK INSERT bronze.crm_sales_orders
from 'C:\Users\eneng\Documents\Retail_Portfolio_Project\DataWareHouse\Datasets\crm\crm_sales_orders.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock);

--ERP

TRUNCATE TABLE bronze.erp_inventory
BULK INSERT bronze.erp_inventory
from 'C:\Users\eneng\Documents\Retail_Portfolio_Project\DataWareHouse\Datasets\ERP\erp_inventory.csv'
WITH(
firstrow = 2,
fieldterminator = ',',
tablock);

TRUNCATE TABLE bronze.erp_product_category
BULK INSERT bronze.erp_product_category
from 'C:\Users\eneng\Documents\Retail_Portfolio_Project\DataWareHouse\Datasets\ERP\erp_product_category.csv'
WITH(
firstrow = 2,
fieldterminator = ',',
tablock);

TRUNCATE TABLE bronze.erp_product_info
BULK INSERT bronze.erp_product_info
from 'C:\Users\eneng\Documents\Retail_Portfolio_Project\DataWareHouse\Datasets\ERP\erp_product_info.csv'
WITH(
firstrow = 2,
fieldterminator = ',',
tablock);	

TRUNCATE TABLE bronze.erp_supplier
BULK INSERT bronze.erp_supplier
from 'C:\Users\eneng\Documents\Retail_Portfolio_Project\DataWareHouse\Datasets\ERP\erp_supplier.csv'
WITH(
firstrow = 2,
fieldterminator = ',',
tablock);	

TRUNCATE TABLE bronze.erp_warehouse
BULK INSERT bronze.erp_warehouse
from 'C:\Users\eneng\Documents\Retail_Portfolio_Project\DataWareHouse\Datasets\ERP\erp_warehouse.csv'
WITH(
firstrow = 2,
fieldterminator = ',',
tablock);	

END TRY

BEGIN CATCH
THROW;
END CATCH

END

EXEC bronze.load_bronze;
