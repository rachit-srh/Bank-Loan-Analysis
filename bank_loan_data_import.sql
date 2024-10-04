--SQL code for Bank Loan Data IMPORT from bank_loan.csv file.

CREATE DATABASE bank_loan_db

CREATE TABLE bank_loan_data
(
    id integer NOT NULL,
    address_state character varying(50) NOT NULL,
    application_type character varying(50) NOT NULL,
    emp_length character varying(50) NOT NULL,
    emp_title character varying(100),
    grade character varying(50) NOT NULL,
    home_ownership character varying(50) NOT NULL,
    issue_date date NOT NULL,
    last_credit_pull_date date NOT NULL,
    last_payment_date date NOT NULL,
    loan_status character varying NOT NULL,
    next_payment_date date NOT NULL,
    member_id integer NOT NULL,
    purpose character varying(50) NOT NULL,
    sub_grade character varying(50) NOT NULL,
    term character varying(50) NOT NULL,
    verification_status character varying(50) NOT NULL,
    annual_income float NOT NULL,
    dti float NOT NULL,
    installment float NOT NULL,
    int_rate float NOT NULL,
    loan_amount integer NOT NULL,
    total_acc integer NOT NULL,
    total_payment integer NOT NULL,
    PRIMARY KEY (id)
);

COPY bank_loan_data(id,address_state,application_type,emp_length,emp_title,grade,home_ownership,issue_date,last_credit_pull_date,last_payment_date,loan_status,next_payment_date,member_id,purpose,sub_grade,term,verification_status,annual_income,dti,installment,int_rate,loan_amount,total_acc,total_payment)
FROM 'C:\SQL\bank_loan.csv'
DELIMITER ','
CSV HEADER;