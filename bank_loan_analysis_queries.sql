--SQL queries for Bank Loan Analysis.

--DASHBOARD 1 : SUMMARY
-- Total Loan Applications.
SELECT COUNT(id) AS "Total_Loan_Applications" FROM bank_loan_data
	
--MTD Total Loan Applications.
SELECT COUNT(id) AS "MTD_Total_Loan_Applications" FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
	
--PMTD Total Loan Applications.
SELECT COUNT(id) AS "PMTD_Total_Loan_Applications" FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11



-- Total Funded Amount
SELECT SUM(loan_amount) AS "Total_Funded_Amount" FROM bank_loan_data
	
--MTD Total Funded Amount
SELECT SUM(loan_amount) AS "MTD_Total_Funded_Amount" FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
	
--PMTD Total Funded Amount
SELECT SUM(loan_amount) AS "PMTD_Total_Funded_Amount" FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11



-- Total Amount Recieved
SELECT SUM(total_payment) AS "Total_Amount_Recieved" FROM bank_loan_data
	
--MTD Total Amount Recieved
SELECT SUM(total_payment) AS "MTD_Total_Amount_Recieved"  FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
	
--PMTD Total Amount Recieved
SELECT SUM(total_payment) AS "PMTD_Total_Amount_Recieved"  FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11



--Average Interest Rate
SELECT ROUND(CAST(AVG(int_rate) * 100 AS NUMERIC), 2) AS "Avg_Int_Rate"  FROM bank_loan_data
	
--MTD Average Interest Rate
SELECT ROUND(CAST(AVG(int_rate) * 100 AS NUMERIC), 2) AS "MTD_Avg_Int_Rate"  FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
	
--PMTD Average Interest Rate
SELECT ROUND(CAST(AVG(int_rate) * 100 AS NUMERIC), 2) AS "PMTD_Avg_Int_Rate"  FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11



--Average DTI
SELECT ROUND(CAST(AVG(dti) * 100 AS NUMERIC), 2) AS "Avg_DTI" FROM bank_loan_data
	
--MTD Average DTI
SELECT ROUND(CAST(AVG(dti) * 100 AS NUMERIC), 2) AS "MTD_Avg_DTI" FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
	
--PMTD Average DTI
SELECT ROUND(CAST(AVG(dti) * 100 AS NUMERIC), 2) AS "PMTD_Avg_DTI" FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11



--GOOD LOAN vs BAD LOAN KPI's
	
--GOOD LOAN KPI'S
--Good Loan Application Percentage
SELECT ROUND(CAST(COUNT(CASE
				WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id
			END) * 100.0 / COUNT (id) AS NUMERIC),2)  AS "Good_Loan_Percentage"
	FROM bank_loan_data

--Good Loan Applications
SELECT COUNT(id) AS "Good_Loan_Applications"
	FROM bank_loan_data
	WHERE loan_status in ('Fully Paid','Current')

--Good Loan Funded Amount
SELECT SUM(loan_amount) AS "Good_Loan_Funded_Amount"
	FROM bank_loan_data
	WHERE loan_status in ('Fully Paid','Current')

--Good Loan Total Recieved Amount
SELECT SUM(total_payment) AS "Good_Loan_Total_Recieved_Amount"
	FROM bank_loan_data
	WHERE loan_status in ('Fully Paid','Current')


	
--BAD LOAN KPI'S
--Bad Loan Applications Percentage
SELECT ROUND(CAST(COUNT(CASE
				WHEN loan_status = 'Charged Off' THEN id
				END) *100.0 / COUNT(id) AS NUMERIC), 2) "Bad_Loan_Applications_Percentage"
			FROM bank_loan_data
				
--Bad Loan Applications
SELECT COUNT(id) AS "Bad_Loan_Applications"
	FROM bank_loan_data
	WHERE loan_status in ('Charged Off')

--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS "Bad_Loan_Funded_Amount"
	FROM bank_loan_data
	WHERE loan_status in ('Charged Off')

--Bad Loan Total Received Amount
SELECT SUM (total_payment) AS "Bad_Loan_Total_Received_Amount"
	FROM bank_loan_data
	WHERE loan_status in ('Charged Off')


	
--LOAN STATUS GRID VIEW
SELECT loan_status,
	COUNT(id) AS "Total_Loan_Applications",
	SUM(loan_amount) AS "Total_Funded_Amount",
	SUM(total_payment) AS "Total_Amount_Recieved",
	ROUND(CAST(AVG(int_rate * 100) AS NUMERIC),2) AS "Avg_Interest_Rate",
	ROUND(CAST(	AVG(dti * 100) AS NUMERIC), 2) AS "Avg_DTI"
	FROM bank_loan_data
		GROUP BY loan_status
		ORDER BY "Total_Loan_Applications" DESC

SELECT loan_status,
	SUM(loan_amount) AS "MTD_Total_Funded_Amount",
	SUM(total_payment) AS "MTD_Total_Amount_Recieved"
	FROM bank_loan_data
		WHERE EXTRACT(MONTH FROM issue_date) = 12
		GROUP BY loan_status
		ORDER BY "MTD_Total_Funded_Amount" DESC



--DASHBOARD 2 : OVERVIEW
--1. Monthly Trends by Issue Date(Line Chart):
SELECT TO_CHAR(issue_date, 'MM') AS "Month_Number",
 	TO_CHAR(issue_date,'Month') AS "Month_Name",
	COUNT(id) AS "Total_Loan_Application",
	SUM(loan_amount) AS "Total_Funded_Amount",
	SUM(total_payment) AS "Total_Amount_Recieved"
	FROM bank_loan_data
		GROUP BY "Month_Number","Month_Name"
		ORDER BY "Total_Loan_Application" DESC

--2. Regional Analysis by State
SELECT address_state,
	COUNT(id) AS "Total_Loan_Application",
	SUM(loan_amount) AS "Total_Funded_Amount",
	SUM(total_payment) AS "Total_Amount_Recieved"
	FROM bank_loan_data
		GROUP BY address_state
		ORDER BY "Total_Loan_Application" DESC

--3. Loan Term Analysis
SELECT term,
	COUNT(id) AS "Total_Loan_Application",
	SUM(loan_amount) AS "Total_Funded_Amount",
	SUM(total_payment) AS "Total_Amount_Recieved"
	FROM bank_loan_data
		GROUP BY term
		ORDER BY "Total_Loan_Application" DESC

--4. Employee Length Analysis
SELECT emp_length,
	COUNT(id) AS "Total_Loan_Application",
	SUM(loan_amount) AS "Total_Funded_Amount",
	SUM(total_payment) AS "Total_Amount_Recieved"
	FROM bank_loan_data
		GROUP BY emp_length
		ORDER BY "Total_Loan_Application" DESC

--5. Loan Purpose Breakdown
SELECT purpose,
	COUNT(id) AS "Total_Loan_Application",
	SUM(loan_amount) AS "Total_Funded_Amount",
	SUM(total_payment) AS "Total_Amount_Recieved"
	FROM bank_loan_data
		GROUP BY purpose
		ORDER BY "Total_Loan_Application" DESC

--6. Home Ownership Analysis
SELECT home_ownership,
	COUNT(id) AS "Total_Loan_Application",
	SUM(loan_amount) AS "Total_Funded_Amount",
	SUM(total_payment) AS "Total_Amount_Recieved"
	FROM bank_loan_data
		GROUP BY home_ownership
		ORDER BY "Total_Loan_Application" DESC

----For Example:
----See the results when we hit the Grade 'A' and Address state 'CA' in the filters for dashboards.
SELECT purpose,
	COUNT(id) AS "Total_Loan_Application",
	SUM(loan_amount) AS "Total_Funded_Amount",
	SUM(total_payment) AS "Total_Amount_Recieved"
	FROM bank_loan_data
	WHERE grade = 'A' AND address_state = 'CA'
		GROUP BY purpose
		ORDER BY "Total_Loan_Application" DESC
