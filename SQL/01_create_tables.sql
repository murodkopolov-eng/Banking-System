GO

---CreditCards---

CREATE TABLE CreditCards (
						  CardID INT IDENTITY(1,1) PRIMARY KEY,
						  CustomerID INT,
						  CardNumber NVARCHAR(50),
						  CardType VARCHAR(50),
						  CVV INT,
						  ExpiryDate DATE,
						  Limit INT,
						  Status VARCHAR(50),
						  CONSTRAINT FK_CreditCards_Customers
						  FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---CreditCardTransactions---

CREATE TABLE CreditCardTransactions (
									 TransactionID  INT IDENTITY(1,1) PRIMARY KEY,
									 CardID INT,
									 Merchant NVARCHAR(200),
									 Amount DECIMAL(10,2),
									 Currency VARCHAR(100),
									 TransactionDate DATE,
									 Status NVARCHAR(50)
									 CONSTRAINT FK_CreditCardTransactions_CreditCards
									 FOREIGN KEY(CardID) REFERENCES CreditCards(CardID))
									 
---Fact Table---

CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100),
    DOB DATE,
    Email VARCHAR(100),
    PhoneNumber NVARCHAR(50),
    Address NVARCHAR(200),
    NationalID NVARCHAR(20),
    TaxID NVARCHAR(20),
    EmploymentStatus VARCHAR(50),
    AnnualIncome DECIMAL(18,2),
    CreatedAt DATETIME,
    UpdatedAt DATETIME
);

---Merchants---

CREATE TABLE Merchants (
					   MerchantID INT IDENTITY(1,1) PRIMARY KEY,
					   MerchantName NVARCHAR(50),
					   Industry NVARCHAR(50),
					   Location NVARCHAR(50),
					   CustomerID INT,
					   CONSTRAINT FK_Merchant_Customers
					   FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---MerchantTransactions---

CREATE TABLE MerchantTransactions (
								   TransactionID INT IDENTITY(1,1) PRIMARY KEY,
								   MerchantID INT,
								   Amount DECIMAL(10,2),
								   PaymentMethod NVARCHAR(50),
								   Date DATE
								   CONSTRAINT FK_MerchantTransactions_Merchants
								   FOREIGN KEY(MerchantID) REFERENCES Merchants(MerchantID))

---AMLCases---

CREATE TABLE AMLCases (
					   CaseID INT IDENTITY(1,1) PRIMARY KEY,
					   CustomerID INT,
					   CaseType VARCHAR(50),
					   Status VARCHAR(50),
					   InvestigatorID INT,
					   CONSTRAINT FK_AMLCases_Customers
					   FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---KYC---

CREATE TABLE KYC (
				  KYCID INT IDENTITY(1,1) PRIMARY KEY,
				  CustomerID INT,
				  DocumentType NVARCHAR(50),
				  DocumentNumber NVARCHAR(50),
				  VerifiedBy NVARCHAR(50),
				  CONSTRAINT FK_KYC_Customers
				  FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---StockTradingAccounts---

CREATE TABLE StockTradingAccounts (
								   AccountID INT IDENTITY(1,1) PRIMARY KEY,
								   CustomerID INT,
								   BrokerageFirm NVARCHAR(50),
								   TotalInvested DECIMAL(10,2),
								   CurrentValue DECIMAL(10,2),
								   CONSTRAINT FK_StockTradingAccounts_Customers
								   FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---ForeignExchange---

CREATE TABLE ForeignExchange (
							  FXID INT IDENTITY(1,1) PRIMARY KEY,
							  CustomerID INT,
							  CurrencyPair NVARCHAR(50),
							  ExchangeRate INT,
							  AmountExchanged DECIMAL(10,2),
							  CONSTRAINT FK_ForeignExchange_Customers
							  FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---DeptCollection---

CREATE TABLE DeptCollection (
							 DeptID INT IDENTITY(1,1) PRIMARY KEY,
							 CustomerID INT,
							 AmountDue DECIMAL(10,2),
							 DueDate DATE,
							 CollectorAssigned NVARCHAR(50),
							 CONSTRAINT FK_DeptCollection_Customers
							 FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---BillPayments---

CREATE TABLE BillPayments (
						   PaymentID INT IDENTITY(1,1) PRIMARY KEY,
						   CustomerID INT,
						   BillerName NVARCHAR(50),
						   Amount DECIMAL(10,2),
						   Date DATE,
						   Status NVARCHAR(50),
						   CONSTRAINT FK_BillPayments_Customers
						   FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---Claim and InsurancePolicies---

CREATE TABLE Claims (
				     ClaimID INT IDENTITY(1,1) PRIMARY KEY,
					 PolicyID INT,
					 ClaimAmount DECIMAL(10,2),
					 Status NVARCHAR(50),
					 FiledDate DATE,
					 CONSTRAINT FK_Claims_InsurancePolicies
					 FOREIGN KEY(PolicyID) REFERENCES InsurancePolicies(PolicyID))

CREATE TABLE InsurancePolicies (
								PolicyID INT IDENTITY(1,1) PRIMARY KEY,
								CustomerID INT,
								InsuranceType NVARCHAR(50),
								PremiumAmount DECIMAL(10,2),
								CoverageAmount DECIMAL(10,2)
								CONSTRAINT FK_InsurancePolicies_Customers
								FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---MobileBankingTransactions---

CREATE TABLE MobileBankingTransactions (
										TransactionID INT IDENTITY(1,1) PRIMARY KEY,
										CustomerID INT,
										DeviceID INT,
										AppVersion INT,
										TransactionType NVARCHAR(50),
										Amount DECIMAL(10,2),
										Date DATE,
										CONSTRAINT FK_MobileBankingTransactions_Customers
										FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---CreditScores---

CREATE TABLE CreditScores (
						   CustomerID INT,
						   CreditScore INT,
						   UpdatedAt DATETIME,
						   CONSTRAINT FK_CreditScores_Customers
						   FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---Loans and LoanPayments---

CREATE TABLE LoanPayments (
						   PaymentID INT IDENTITY(1,1) PRIMARY KEY,
						   LoanID INT,
						   AmountPaid DECIMAL(10,2),
						   PaymentDate DATE,
						   RemainingBalance DECIMAL(10,2),
						   CONSTRAINT FK_LoanPayments_Loans
						   FOREIGN KEY(LoanID) REFERENCES Loans(LoanID))

CREATE TABLE Loans (
					LoanID INT IDENTITY(1,1)PRIMARY KEY,
					CustomerID INT,
					LoanType NVARCHAR(50),
					Amount DECIMAL(10,2),
					InterestRate INT,
					StartDate DATE,
					EndDate DATE,
					Status VARCHAR(50),
					CONSTRAINT FK_Loans_Customers
					FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---Investments---

CREATE TABLE Investments (
						  InvestmentID INT IDENTITY(1,1) PRIMARY KEY,
						  CustomerID INT,
						  InvestmentType NVARCHAR(50),
						  Amount DECIMAL(10,2),
						  ROI DECIMAL(10,2),
						  MaturityDate DATE,
						  CONSTRAINT FK_Investments_Customers
						  FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---FraudDetection---

CREATE TABLE FraudDetection (
							 FraudID INT IDENTITY(1,1) PRIMARY KEY,
							 CustomerID INT,
							 TransactionID INT,
							 RiskLevel INT,
							 ReportedDate DATE,
							  CONSTRAINT FK_FraudDetection_Customers
							 FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---OnlineBankingUsers and UserAccessLogs---

CREATE TABLE UserAccessLogs (
							 LogID INT IDENTITY(1,1) PRIMARY KEY,
							 UserID INT,
							 ActionType NVARCHAR(50),
							 Timestamp DATETIME,
							 CONSTRAINT FK_UserAccessLogs_OnlineBankingUsers
							 FOREIGN KEY(UserID) REFERENCES OnlineBankingUsers(UserID))

CREATE TABLE OnlineBankingUsers (
								 UserID INT IDENTITY(1,1) PRIMARY KEY,
								 CustomerID INT,
								 Username NVARCHAR(50),
								 PasswordHash NVARCHAR(255),
								 LastLogin DATETIME,
								 CONSTRAINT FK_OnlineBankingUsers_Customers
								 FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))

---Branches---

CREATE TABLE Branches (
					   BranchID INT IDENTITY(1,1) PRIMARY KEY,
					   BranchName NVARCHAR(50),
					   Address NVARCHAR(50),
					   City NVARCHAR(50), 
					   State NVARCHAR(50), 
					   Country NVARCHAR(50),
					   ManagerID INT,
					   ContactNumber INT )

---Employees---

CREATE TABLE Employees (
						EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
						BranchID  INT,
						FullName NVARCHAR(50),
						Position NVARCHAR(50),
						Department NVARCHAR(50),
						Salary DECIMAL(10,2),
						HireDate DATE,
						Status NVARCHAR(50),
						CONSTRAINT FK_Employees_Branches
						FOREIGN KEY(BranchID) REFERENCES Branches(BranchID))

---Salaries---

CREATE TABLE Salaries (
					   SalaryID INT IDENTITY(1,1) PRIMARY KEY,
					   EmployeeID INT,
					   BaseSalary DECIMAL(10,2),
					   Bonus DECIMAL(10,2),
					   Deductions DECIMAL(10,2),
					   PaymentDate DATE,
					   CONSTRAINT FK_Salaries_Employees
					   FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID))

---	Departments---

CREATE TABLE Departments (
						  DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
						  EmployeeID INT,
						  DepartmentName NVARCHAR(50),
						  ManagerID INT,
						  CONSTRAINT FK_Departments_Employees
                          FOREIGN KEY(ManagerID) REFERENCES Employees(EmployeeID))

---EmployeeAttendance---

CREATE TABLE EmployeeAttendance (
								 AttendanceID INT IDENTITY(1,1) PRIMARY KEY,
								 EmployeeID INT,
								 CheckInTime DATETIME,
								 CheckOutTime DATETIME,
								 TotalHours INT,
								 CONSTRAINT FK_EmployeeAttendance_Employees
								 FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID))

---Accounts---

CREATE TABLE Accounts (
					   AccountID INT IDENTITY(1,1) PRIMARY KEY,
					   CustomerID INT,
					   AccountType NVARCHAR(50),
					   Balance DECIMAL(10,2),
					   Currency VARCHAR(50),
					   Status NVARCHAR(50),
					   BranchID INT,
					   CreatedDate DATE
					   CONSTRAINT FK_Accounts_Customers
					   FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID))
ALTER TABLE Accounts
ADD CONSTRAINT FK_FK_Accounts2 FOREIGN KEY(BranchID) REFERENCES Branches(BranchID)

---Transactions---

CREATE TABLE Transactions (
						   TransactionID INT IDENTITY(1,1) PRIMARY KEY,
						   AccountID INT,
						   TransactionType NVARCHAR(50),
						   Amount DECIMAL(10,2),
						   Currency NVARCHAR(50),
						   Date DATETIME2,
						   Status NVARCHAR(50),
						   ReferenceNo INT,
						   CONSTRAINT FK_Transactions_Accounts
						   FOREIGN KEY(AccountID) REFERENCES Accounts(AccountID))

---RegulatoryReports---

CREATE TABLE RegulatoryReports (
						        ReportID INT IDENTITY(1,1) PRIMARY KEY,
								ReportType NVARCHAR(50),
								SubmissionDate DATE )

---CyberSecurityIncidents---

CREATE TABLE CyberSecurityIncidents (
									 IncidentID INT IDENTITY(1,1) PRIMARY KEY,
									 AffectedSystem NVARCHAR(50), 
									 ReportedDate DATE,
									 ResolutionStatus NVARCHAR(50))
