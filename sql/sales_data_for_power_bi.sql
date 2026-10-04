CREATE OR REPLACE VIEW classicmodels.sales_data_for_power_bi AS
SELECT
    orderdate,
    ord.ordernumber,
    p.productName,
    p.productLine,
    c.customerName,
    c.city     AS customer_city,
    c.country  AS customer_country,
    o.city     AS office_city,
    o.country  AS office_country,
    buyPrice,
    priceEach,
    QuantityOrdered,
    SUM(QuantityOrdered) * SUM(priceEach) AS sales_value,
    SUM(buyPrice) * SUM(quantityOrdered)  AS cost_of_sales
FROM classicmodels.orders ord
LEFT JOIN classicmodels.orderdetails od ON ord.orderNumber = od.orderNumber
LEFT JOIN classicmodels.customers c     ON ord.customerNumber = c.customerNumber
LEFT JOIN classicmodels.products p      ON od.productCode = p.productCode
LEFT JOIN classicmodels.employees e     ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN classicmodels.offices o       ON e.officeCode = o.officeCode
GROUP BY
    orderdate, ord.ordernumber, p.productName, p.productLine,
    c.customerName, c.city, c.country, o.city, o.country,
    buyPrice, priceEach, QuantityOrdered;
