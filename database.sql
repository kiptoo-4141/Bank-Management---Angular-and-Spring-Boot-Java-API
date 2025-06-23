-- Create SecureBank Database
CREATE DATABASE SecureBank;
USE SecureBank;

-- Users Table
CREATE TABLE users (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    country VARCHAR(50) NOT NULL,
    national_id VARCHAR(50) UNIQUE NOT NULL,
    occupation VARCHAR(100),
    annual_income DECIMAL(15,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active'
);

-- Account Types Table
CREATE TABLE account_types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL,
    description TEXT,
    minimum_balance DECIMAL(10,2) DEFAULT 0.00,
    interest_rate DECIMAL(5,4) DEFAULT 0.0000,
    monthly_fee DECIMAL(10,2) DEFAULT 0.00
);

-- Bank Accounts Table
CREATE TABLE bank_accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    user_id BIGINT NOT NULL,
    account_type_id INT NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    available_balance DECIMAL(15,2) DEFAULT 0.00,
    overdraft_limit DECIMAL(10,2) DEFAULT 0.00,
    branch_code VARCHAR(10) NOT NULL,
    opened_date DATE NOT NULL,
    status ENUM('active', 'closed', 'frozen') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (account_type_id) REFERENCES account_types(type_id)
);

-- Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    transaction_type ENUM('deposit', 'withdrawal', 'transfer_in', 'transfer_out', 'fee', 'interest') NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    balance_after DECIMAL(15,2) NOT NULL,
    description VARCHAR(200),
    reference_number VARCHAR(50) UNIQUE,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'completed', 'failed', 'cancelled') DEFAULT 'completed',
    FOREIGN KEY (account_id) REFERENCES bank_accounts(account_id) ON DELETE CASCADE
);

-- Loans Table
CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    loan_type ENUM('personal', 'home', 'auto', 'business', 'student') NOT NULL,
    principal_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,4) NOT NULL,
    term_months INT NOT NULL,
    monthly_payment DECIMAL(10,2) NOT NULL,
    outstanding_balance DECIMAL(15,2) NOT NULL,
    application_date DATE NOT NULL,
    approval_date DATE,
    disbursement_date DATE,
    status ENUM('pending', 'approved', 'disbursed', 'active', 'closed', 'defaulted') DEFAULT 'pending',
    collateral_description TEXT,
    purpose VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Loan Payments Table
CREATE TABLE loan_payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    payment_amount DECIMAL(10,2) NOT NULL,
    principal_payment DECIMAL(10,2) NOT NULL,
    interest_payment DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    due_date DATE NOT NULL,
    status ENUM('paid', 'late', 'missed') DEFAULT 'paid',
    payment_method VARCHAR(50),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id) ON DELETE CASCADE
);

-- Credit Cards Table
CREATE TABLE credit_cards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    card_number VARCHAR(20) UNIQUE NOT NULL,
    card_type ENUM('visa', 'mastercard', 'amex') NOT NULL,
    credit_limit DECIMAL(10,2) NOT NULL,
    available_credit DECIMAL(10,2) NOT NULL,
    current_balance DECIMAL(10,2) DEFAULT 0.00,
    interest_rate DECIMAL(5,4) NOT NULL,
    expiry_date DATE NOT NULL,
    issue_date DATE NOT NULL,
    status ENUM('active', 'blocked', 'expired', 'cancelled') DEFAULT 'active',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Invoices/Bills Table
CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    service_type ENUM('loan_payment', 'credit_card', 'account_fee', 'overdraft_fee', 'service_charge') NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    due_date DATE NOT NULL,
    issue_date DATE NOT NULL,
    payment_date DATE NULL,
    status ENUM('pending', 'paid', 'overdue', 'cancelled') DEFAULT 'pending',
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Branches Table
CREATE TABLE branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_code VARCHAR(10) UNIQUE NOT NULL,
    branch_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    manager_name VARCHAR(100),
    opening_hours VARCHAR(100)
);

-- Insert Sample Data

-- Insert Account Types
INSERT INTO account_types (type_name, description, minimum_balance, interest_rate, monthly_fee) VALUES
('Savings', 'Basic savings account with interest', 100.00, 0.0150, 0.00),
('Checking', 'Standard checking account for daily transactions', 0.00, 0.0000, 5.00),
('Premium Savings', 'High-yield savings account', 5000.00, 0.0250, 0.00),
('Business Checking', 'Business checking account', 500.00, 0.0050, 15.00),
('Student Account', 'Special account for students', 0.00, 0.0100, 0.00);

-- Insert Branches
INSERT INTO branches (branch_code, branch_name, address, city, state, zip_code, phone, manager_name, opening_hours) VALUES
('BR001', 'Downtown Branch', '123 Main St', 'New York', 'NY', '10001', '212-555-0101', 'John Smith', '9AM-5PM Mon-Fri'),
('BR002', 'Uptown Branch', '456 Park Ave', 'New York', 'NY', '10002', '212-555-0102', 'Sarah Johnson', '9AM-5PM Mon-Fri'),
('BR003', 'Brooklyn Branch', '789 Brooklyn Ave', 'Brooklyn', 'NY', '11201', '718-555-0103', 'Mike Davis', '9AM-5PM Mon-Fri'),
('BR004', 'Queens Branch', '321 Queens Blvd', 'Queens', 'NY', '11375', '718-555-0104', 'Lisa Chen', '9AM-5PM Mon-Fri'),
('BR005', 'Bronx Branch', '654 Bronx St', 'Bronx', 'NY', '10451', '718-555-0105', 'Robert Wilson', '9AM-5PM Mon-Fri');

-- Insert Users
INSERT INTO users (first_name, last_name, email, phone, date_of_birth, address, city, state, zip_code, country, national_id, occupation, annual_income) VALUES
('Alice', 'Johnson', 'alice.johnson@email.com', '555-0001', '1985-03-15', '123 Oak St', 'New York', 'NY', '10001', 'USA', 'SSN123456789', 'Software Engineer', 85000.00),
('Bob', 'Smith', 'bob.smith@email.com', '555-0002', '1990-07-22', '456 Pine St', 'New York', 'NY', '10002', 'USA', 'SSN234567890', 'Marketing Manager', 65000.00),
('Carol', 'Davis', 'carol.davis@email.com', '555-0003', '1988-11-08', '789 Elm St', 'Brooklyn', 'NY', '11201', 'USA', 'SSN345678901', 'Teacher', 45000.00),
('David', 'Wilson', 'david.wilson@email.com', '555-0004', '1992-01-30', '321 Maple St', 'Queens', 'NY', '11375', 'USA', 'SSN456789012', 'Accountant', 55000.00),
('Emma', 'Brown', 'emma.brown@email.com', '555-0005', '1987-09-14', '654 Cedar St', 'Bronx', 'NY', '10451', 'USA', 'SSN567890123', 'Nurse', 60000.00),
('Frank', 'Taylor', 'frank.taylor@email.com', '555-0006', '1983-12-03', '987 Birch St', 'New York', 'NY', '10003', 'USA', 'SSN678901234', 'Business Owner', 95000.00),
('Grace', 'Anderson', 'grace.anderson@email.com', '555-0007', '1991-05-18', '147 Walnut St', 'Brooklyn', 'NY', '11202', 'USA', 'SSN789012345', 'Designer', 52000.00),
('Henry', 'Thomas', 'henry.thomas@email.com', '555-0008', '1989-08-25', '258 Spruce St', 'Queens', 'NY', '11376', 'USA', 'SSN890123456', 'Engineer', 72000.00),
('Ivy', 'Jackson', 'ivy.jackson@email.com', '555-0009', '1986-04-12', '369 Ash St', 'Bronx', 'NY', '10452', 'USA', 'SSN901234567', 'Doctor', 120000.00),
('Jack', 'White', 'jack.white@email.com', '555-0010', '1993-10-07', '741 Poplar St', 'New York', 'NY', '10004', 'USA', 'SSN012345678', 'Student', 15000.00),
('Kate', 'Harris', 'kate.harris@email.com', '555-0011', '1984-06-21', '852 Willow St', 'Brooklyn', 'NY', '11203', 'USA', 'SSN123450987', 'Lawyer', 110000.00),
('Leo', 'Martin', 'leo.martin@email.com', '555-0012', '1990-02-28', '963 Cherry St', 'Queens', 'NY', '11377', 'USA', 'SSN234561098', 'Sales Rep', 48000.00),
('Mia', 'Garcia', 'mia.garcia@email.com', '555-0013', '1988-12-16', '159 Peach St', 'Bronx', 'NY', '10453', 'USA', 'SSN345672109', 'HR Manager', 68000.00),
('Noah', 'Rodriguez', 'noah.rodriguez@email.com', '555-0014', '1991-07-04', '357 Plum St', 'New York', 'NY', '10005', 'USA', 'SSN456783210', 'IT Specialist', 62000.00),
('Olivia', 'Lewis', 'olivia.lewis@email.com', '555-0015', '1985-09-11', '456 Apple St', 'Brooklyn', 'NY', '11204', 'USA', 'SSN567894321', 'Pharmacist', 88000.00);

-- Insert Bank Accounts
INSERT INTO bank_accounts (account_number, user_id, account_type_id, balance, available_balance, overdraft_limit, branch_code, opened_date) VALUES
('ACC1001234567890', 1, 1, 15000.00, 15000.00, 0.00, 'BR001', '2023-01-15'),
('ACC1001234567891', 2, 2, 2500.00, 2500.00, 500.00, 'BR001', '2023-02-20'),
('ACC1001234567892', 3, 1, 8200.00, 8200.00, 0.00, 'BR003', '2023-03-10'),
('ACC1001234567893', 4, 2, 3750.00, 3750.00, 1000.00, 'BR004', '2023-04-05'),
('ACC1001234567894', 5, 1, 12500.00, 12500.00, 0.00, 'BR005', '2023-05-12'),
('ACC1001234567895', 6, 4, 25000.00, 25000.00, 5000.00, 'BR001', '2023-06-18'),
('ACC1001234567896', 7, 2, 4200.00, 4200.00, 500.00, 'BR003', '2023-07-22'),
('ACC1001234567897', 8, 1, 9800.00, 9800.00, 0.00, 'BR004', '2023-08-14'),
('ACC1001234567898', 9, 3, 45000.00, 45000.00, 0.00, 'BR005', '2023-09-08'),
('ACC1001234567899', 10, 5, 850.00, 850.00, 0.00, 'BR001', '2023-10-01'),
('ACC1001234567800', 11, 1, 18500.00, 18500.00, 0.00, 'BR003', '2023-11-15'),
('ACC1001234567801', 12, 2, 3200.00, 3200.00, 1000.00, 'BR004', '2023-12-03'),
('ACC1001234567802', 13, 1, 11200.00, 11200.00, 0.00, 'BR005', '2024-01-20'),
('ACC1001234567803', 14, 2, 5500.00, 5500.00, 500.00, 'BR001', '2024-02-14'),
('ACC1001234567804', 15, 1, 14800.00, 14800.00, 0.00, 'BR003', '2024-03-08');

-- Insert Transactions
INSERT INTO transactions (account_id, transaction_type, amount, balance_after, description, reference_number) VALUES
(1, 'deposit', 5000.00, 15000.00, 'Initial deposit', 'TXN001'),
(2, 'deposit', 2500.00, 2500.00, 'Salary deposit', 'TXN002'),
(3, 'deposit', 8200.00, 8200.00, 'Transfer from savings', 'TXN003'),
(4, 'withdrawal', 250.00, 3750.00, 'ATM withdrawal', 'TXN004'),
(5, 'deposit', 12500.00, 12500.00, 'Business income', 'TXN005'),
(6, 'deposit', 25000.00, 25000.00, 'Business account opening', 'TXN006'),
(7, 'withdrawal', 800.00, 4200.00, 'Online purchase', 'TXN007'),
(8, 'deposit', 9800.00, 9800.00, 'Investment return', 'TXN008'),
(9, 'deposit', 45000.00, 45000.00, 'Premium savings deposit', 'TXN009'),
(10, 'deposit', 850.00, 850.00, 'Student loan disbursement', 'TXN010'),
(11, 'deposit', 18500.00, 18500.00, 'Legal fees received', 'TXN011'),
(12, 'withdrawal', 300.00, 3200.00, 'Grocery shopping', 'TXN012'),
(13, 'deposit', 11200.00, 11200.00, 'Salary deposit', 'TXN013'),
(14, 'transfer_in', 5500.00, 5500.00, 'Transfer from checking', 'TXN014'),
(15, 'deposit', 14800.00, 14800.00, 'Pharmacy income', 'TXN015');

-- Insert Loans
INSERT INTO loans (user_id, loan_type, principal_amount, interest_rate, term_months, monthly_payment, outstanding_balance, application_date, approval_date, disbursement_date, status, purpose) VALUES
(1, 'home', 250000.00, 0.0375, 360, 1154.01, 245000.00, '2023-01-10', '2023-01-25', '2023-02-01', 'active', 'Home purchase'),
(2, 'auto', 25000.00, 0.0450, 60, 466.08, 22000.00, '2023-02-15', '2023-02-28', '2023-03-05', 'active', 'Car purchase'),
(3, 'personal', 15000.00, 0.0650, 48, 364.58, 12500.00, '2023-03-01', '2023-03-10', '2023-03-15', 'active', 'Debt consolidation'),
(4, 'student', 35000.00, 0.0425, 120, 361.45, 32000.00, '2023-04-01', '2023-04-15', '2023-04-20', 'active', 'Graduate school'),
(5, 'personal', 10000.00, 0.0575, 36, 306.92, 8500.00, '2023-05-05', '2023-05-15', '2023-05-20', 'active', 'Medical expenses'),
(6, 'business', 100000.00, 0.0525, 84, 1482.73, 95000.00, '2023-06-10', '2023-06-25', '2023-07-01', 'active', 'Business expansion'),
(7, 'auto', 18000.00, 0.0475, 48, 413.15, 15000.00, '2023-07-15', '2023-07-28', '2023-08-02', 'active', 'Used car purchase'),
(8, 'home', 180000.00, 0.0395, 240, 1103.47, 175000.00, '2023-08-05', '2023-08-20', '2023-08-25', 'active', 'Home refinance'),
(9, 'personal', 20000.00, 0.0625, 60, 391.32, 18000.00, '2023-09-01', '2023-09-12', '2023-09-18', 'active', 'Home renovation'),
(10, 'student', 15000.00, 0.0350, 120, 149.85, 14500.00, '2023-10-01', '2023-10-10', '2023-10-15', 'active', 'College tuition'),
(11, 'personal', 12000.00, 0.0680, 42, 325.47, 10000.00, '2023-11-10', '2023-11-20', '2023-11-25', 'active', 'Legal expenses'),
(12, 'auto', 22000.00, 0.0455, 72, 355.28, 20000.00, '2023-12-01', '2023-12-12', '2023-12-18', 'active', 'New car purchase'),
(13, 'personal', 8000.00, 0.0595, 24, 364.85, 6500.00, '2024-01-15', '2024-01-25', '2024-02-01', 'active', 'Wedding expenses'),
(14, 'business', 50000.00, 0.0545, 60, 961.54, 47000.00, '2024-02-10', '2024-02-22', '2024-03-01', 'active', 'Equipment purchase'),
(15, 'home', 300000.00, 0.0385, 360, 1395.95, 298000.00, '2024-03-01', '2024-03-15', '2024-03-20', 'active', 'New home purchase');

-- Insert Loan Payments
INSERT INTO loan_payments (loan_id, payment_amount, principal_payment, interest_payment, payment_date, due_date) VALUES
(1, 1154.01, 375.26, 778.75, '2024-03-01', '2024-03-01'),
(2, 466.08, 383.00, 83.08, '2024-04-05', '2024-04-05'),
(3, 364.58, 283.33, 81.25, '2024-04-15', '2024-04-15'),
(4, 361.45, 237.92, 123.53, '2024-05-20', '2024-05-20'),
(5, 306.92, 258.17, 48.75, '2024-06-20', '2024-06-20'),
(6, 1482.73, 1065.07, 417.66, '2024-08-01', '2024-08-01'),
(7, 413.15, 342.50, 70.65, '2024-09-02', '2024-09-02'),
(8, 1103.47, 521.77, 581.70, '2024-09-25', '2024-09-25'),
(9, 391.32, 295.82, 95.50, '2024-10-18', '2024-10-18'),
(10, 149.85, 108.10, 41.75, '2024-11-15', '2024-11-15'),
(11, 325.47, 257.80, 67.67, '2024-12-25', '2024-12-25'),
(12, 355.28, 271.95, 83.33, '2025-01-18', '2025-01-18'),
(13, 364.85, 325.52, 39.33, '2025-03-01', '2025-03-01'),
(14, 961.54, 746.04, 215.50, '2025-04-01', '2025-04-01'),
(15, 1395.95, 432.29, 963.66, '2025-04-20', '2025-04-20');

-- Insert Credit Cards
INSERT INTO credit_cards (user_id, card_number, card_type, credit_limit, available_credit, current_balance, interest_rate, expiry_date, issue_date) VALUES
(1, '4111111111111111', 'visa', 5000.00, 4200.00, 800.00, 0.1899, '2027-01-31', '2023-01-15'),
(2, '5555555555554444', 'mastercard', 3000.00, 2750.00, 250.00, 0.1799, '2026-12-31', '2023-02-20'),
(3, '4000000000000002', 'visa', 2500.00, 2100.00, 400.00, 0.1999, '2027-03-31', '2023-03-10'),
(4, '5105105105105100', 'mastercard', 4000.00, 3600.00, 400.00, 0.1849, '2026-11-30', '2023-04-05'),
(5, '4242424242424242', 'visa', 6000.00, 5300.00, 700.00, 0.1749, '2027-05-31', '2023-05-12'),
(6, '5431111111111111', 'mastercard', 10000.00, 8500.00, 1500.00, 0.1599, '2026-10-31', '2023-06-18'),
(7, '4000000000000077', 'visa', 2000.00, 1850.00, 150.00, 0.2099, '2027-07-31', '2023-07-22'),
(8, '5200828282828210', 'mastercard', 7000.00, 6400.00, 600.00, 0.1699, '2026-09-30', '2023-08-14'),
(9, '378282246310005', 'amex', 15000.00, 13500.00, 1500.00, 0.1499, '2027-09-30', '2023-09-08'),
(10, '4000000000000036', 'visa', 1000.00, 950.00, 50.00, 0.2199, '2027-10-31', '2023-10-01'),
(11, '5555555555554477', 'mastercard', 8000.00, 7200.00, 800.00, 0.1649, '2026-08-31', '2023-11-15'),
(12, '4111111111111129', 'visa', 3500.00, 3200.00, 300.00, 0.1899, '2027-12-31', '2023-12-03'),
(13, '5105105105105108', 'mastercard', 4500.00, 4100.00, 400.00, 0.1799, '2027-01-31', '2024-01-20'),
(14, '4242424242424250', 'visa', 5500.00, 5000.00, 500.00, 0.1749, '2027-02-28', '2024-02-14'),
(15, '5431111111111129', 'mastercard', 9000.00, 8100.00, 900.00, 0.1599, '2027-03-31', '2024-03-08');

-- Insert Invoices
INSERT INTO invoices (user_id, invoice_number, service_type, amount, due_date, issue_date, status, description) VALUES
(1, 'INV-2024-001', 'loan_payment', 1154.01, '2024-06-01', '2024-05-01', 'paid', 'Monthly mortgage payment'),
(2, 'INV-2024-002', 'credit_card', 250.00, '2024-06-15', '2024-05-15', 'paid', 'Credit card minimum payment'),
(3, 'INV-2024-003', 'account_fee', 5.00, '2024-06-01', '2024-05-01', 'paid', 'Monthly account maintenance fee'),
(4, 'INV-2024-004', 'loan_payment', 361.45, '2024-06-20', '2024-05-20', 'pending', 'Student loan payment'),
(5, 'INV-2024-005', 'overdraft_fee', 35.00, '2024-06-10', '2024-05-25', 'overdue', 'Overdraft protection fee'),
(6, 'INV-2024-006', 'service_charge', 15.00, '2024-06-01', '2024-05-01', 'paid', 'Business account monthly fee'),
(7, 'INV-2024-007', 'credit_card', 150.00, '2024-06-25', '2024-05-25', 'pending', 'Credit card payment due'),
(8, 'INV-2024-008', 'loan_payment', 1103.47, '2024-06-25', '2024-05-25', 'paid', 'Home refinance payment'),
(9, 'INV-2024-009', 'account_fee', 0.00, '2024-06-01', '2024-05-01', 'paid', 'Premium savings - no fee'),
(10, 'INV-2024-010', 'loan_payment', 149.85, '2024-06-15', '2024-05-15', 'paid', 'Student loan payment'),
(11, 'INV-2024-011', 'service_charge', 25.00, '2024-06-20', '2024-05-20', 'pending', 'Wire transfer fee'),
(12, 'INV-2024-012', 'credit_card', 300.00, '2024-06-18', '2024-05-18', 'paid', 'Credit card payment'),
(13, 'INV-2024-013', 'loan_payment', 364.85, '2024-06-01', '2024-05-01', 'pending', 'Personal loan payment'),
(14, 'INV-2024-014', 'account_fee', 5.00, '2024-06-14', '2024-05-14', 'paid', 'Checking account fee'),
(15, 'INV-2024-015', 'loan_payment', 1395.95, '2024-06-20', '2024-05-20', 'pending', 'New home mortgage payment');

-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_national_id ON users(national_id);
CREATE INDEX idx_bank_accounts_user_id ON bank_accounts(user_id);
CREATE INDEX idx_bank_accounts_account_number ON bank_accounts(account_number);
CREATE INDEX idx_transactions_account_id ON transactions(account_id);
CREATE INDEX idx_transactions_date ON transactions(transaction_date);
CREATE INDEX idx_loans_user_id ON loans(user_id);
CREATE INDEX idx_credit_cards_user_id ON credit_cards(user_id);