' TABLES     PAYROLL APPLICATION
' This Program is to Calculate Gross Pay for Employee's with a valid Employee Number.
'    When Valid - Calculate the Gross Pay based upon Hours * Rate     (from the table, based on the Code)
'    When Not Valid - do not calculate.  Output an error line with an appropriate message.

' Contains 2 tables.
'  I)  The Pay Rate Table contains the available hourly pay rates for all employees, based upon the Input Pay
'                Code Field.
'           There are 5 pay codes.
'           All Rates are Valid
'           Use a  Definite Iteration Table Load and Direct Relationship table retrieval

'  II)  The Employee Table holds Employee ID's  for all 'valid' employees.
'               Use an Indefinite Iteration Table Load and a Table Search (table type is Indirect Relationship)
'                       to determine if the input Employee ID is valid  (matches one in the table).

'VARIABLES USED IN THE PROGRAM:
'Table Fields:
GLOBAL  PAY.RATE.TABLE            'Name of the table to hold the 5 pay rates
GLOBAL  EMPLOYEEID.TABLE$                                 'Name of the table to hold the EMPLOYEE's Identification (ID)

GLOBAL PAY.RATE                            ' Input Pay Rate field to load table (same name as below-similar but not same use)
GLOBAL EmployeeID$                         ' Input Employee Identification for the TABLE LOAD process

GLOBAL PR.Subscript                             ' Subscript used to load Pay Rate Table (Pay Rate Subscript)
GLOBAL EMP.Subscript                         ' Subscript used to load Employee ID  Table (Employee Subscript)

GLOBAL SAVE.Subscript                     'To save # of Employee ID's loaded into the EmployeeID table this pay period

GLOBAL MaximumNumberEmployees           'Assigned 'constant' field to hold the maximum number of Employees

'Table Searching Fields:
GLOBAL FOUND.EmployeeID$                 ' Switch/Flag set to Y when the Input EmployeeID matches a ID in the table
GLOBAL SEARCH.Subscript                 ' Subscript used for Searching the Employee ID in the table.

'Input Variables:
GLOBAL EmployeeID$                    ' Employee's Identification Value
GLOBAL Name$                       ' Employee's name
GLOBAL Hours                       ' Hours Worked by an employee
GLOBAL PayCode                    ' Pay code - 1 through 5

'Output Variables:
' EmployeeID$, Name$, Hours, PayCode
GLOBAL PAY.RATE                            '(ALTERNATIVE FIELD: - Hourly pay rate, based upon the code, extracted from the table
GLOBAL GROSS                   ' Gross Pay determined by multiplying Hours by PAY.RATE

GOSUB [Start]                              ' Mainline Processing
DO WHILE eof(#EmployeePayRollFile) = 0                            ' TEST the PROCESSED File Here
     GOSUB [ProcessRecords]
LOOP
GOSUB [WrapUp]
END

[Start]
  GOSUB [Initialize]
  GOSUB [OpenFiles]
  GOSUB [PayRate.LoadFile]                'Table data must be loaded into from data file
  GOSUB [Employee.LoadFile]               '  to the table in memory prior to using it in regular processing
  GOSUB [Headings]
  GOSUB [ReadFile]
RETURN

[ProcessRecords]
   GOSUB [EmployeeID.Lookup]                       ' Determine IF Record Processed or Error & output Error Message
    IF FOUND.EmployeeID$ = "Y" THEN            ' Test Flag & process valid records or print error message if invalid Emp ID
        GOSUB [Detail.Calculations]                       'Detail Processing for Valid Records
        GOSUB [DetailPrint]
    ELSE
        GOSUB [ErrorPrint]                          'Error Processing for Invalid Records - completely different line
    END IF                                            '       printed from when a Record is processed as Valid
   GOSUB [ReadFile]
RETURN

[WrapUp]                    ' End of Program Processing - summary line  & close files
  GOSUB [SummaryOutput]
  GOSUB [CloseFile]
RETURN

[Initialize]
     MaximumNumberEmployees = 50                                      ' Initialize Maximum # of  Employees

' Table Definitions
     DIM PAY.RATE.TABLE(5)                                                                 'Defines Table Name, Type (Alpha/Numeric)
     DIM EMPLOYEEID.TABLE$(MaximumNumberEmployees)                 'and Size (# of elements) in the table
RETURN

[OpenFiles]
   OPEN "PayRateTableFile.dat" FOR INPUT AS #PayRateFile                             'Pay Rate Table
   OPEN "EmployeeSSNTableFile.dat" FOR INPUT AS #EmployeeSocSecFile     'Social Security # Table - valid Employees
   OPEN "EmployeeFile.dat" FOR INPUT AS #EmployeePayRollFile                             'Processing file
RETURN

[PayRate.LoadFile]                                              'Loops using FOR NEXT to load Pay Rates Table with an
   FOR PR.Subscript = 1 TO 5                        '  DEFINITE ITERATION Table Load
      INPUT #PayRateFile,    PayRate
      PAY.RATE.TABLE(PR.Subscript) = PayRate
  NEXT PR.Subscript
RETURN

[Employee.LoadFile]                                   ' Loops using FOR NEXT to load Social Security Numbers into the table
   INPUT #EmployeeSocSecFile,  EmployeeID$                          '        with an INDEFINITE ITERATION - Priming Read
   FOR EMP.Subscript = 1 TO MaximumNumberEmployees
         IF  EmployeeID$ = "ENDTABLE" THEN                                ' Decision if EOF reached in EmployeeID$ file
               SAVE.Subscript = EMP.Subscript - 1                      ' Set SAVE for Search Loop
               EMP.Subscript = MaximumNumberEmployees                         ' Set Subscript to MaxSize = early loop exit
        ELSE
              EMPLOYEEID.TABLE$(EMP.Subscript) = EmployeeID$
              INPUT #EmployeeSocSecFile,  EmployeeID$
       END IF
   NEXT EMP.Subscript
RETURN

[Headings]
   PRINT   TAB(31); "PAYROLL LISTING"                                   'Report Header Output Line
   PRINT
   PRINT                                                                        'Column Header Output Line
   PRINT TAB(3); "EMPLOYEE"; TAB(20); "EMPLOYEE"; TAB(41); "HOURS"; TAB(49); "PAY"; TAB(56); "PAY";
   PRINT TAB(65); "GROSS"
   PRINT TAB(3); "NUMBER"; TAB(20); "NAME"; TAB(40); "WORKED";
   PRINT TAB(48);"CODE"; TAB(55); "RATE"; TAB(67); "PAY"
   PRINT
RETURN

[ReadFile]
    INPUT #EmployeePayRollFile, EmployeeID$, Name$, Hours, PayCode                 ' Processed data file read
RETURN

 [EmployeeID.Lookup]                                                 'Sequential Search for Valid Social Security Number
    FOUND.EmployeeID$ = "N"                                         ' Initialize Flag before starting the search
    FOR SEARCH.Subscript = 1 TO SAVE.Subscript                 '         loop
         GOSUB [EmployeeID.Check]                                     ' execute module to compare SSN's
    NEXT SEARCH.Subscript
RETURN

[EmployeeID.Check]                                              ' Compare of input SSN with Table SSN's
    IF EmployeeID$= EMPLOYEEID.TABLE$(SEARCH.Subscript) THEN
         FOUND.EmployeeID$= "Y"                                  ' Flag set to Y when input SSN matches table SSN
         SEARCH.Subscript = SAVE.Subscript                       ' set subscript to highest value to exit loop
    END IF
RETURN

[Detail.Calculations]                                                         ' Calculate Gross Pay for Valid Employees
      Gross = Hours * PAY.RATE.TABLE(PayCode)           ' Pay code determines which pay rate
RETURN                                                                               '     is used in the calculation DIRECT RELATIONSHIP

' ***************************************************************************
' *                ALTERNATIVE DETAIL CALCULATION PROCESSING]
' *                            PayRate = PAY.RATE.TABLE(PayCode)
' *                            Gross = Hours * PayRate
' ***************************************************************************

[DetailPrint]                                               ' Line that Prints for Valid & Processed Employees
   PRINT
   PRINT TAB(3); EmployeeID$;
   PRINT TAB(20); Name$;
   PRINT TAB(42); USING("##.#", Hours);
   PRINT TAB(51); USING("#", PayCode);
   PRINT TAB(54); USING("##.##", PAY.RATE.TABLE(PayCode));
   PRINT TAB(62); "$"; USING("####.##", Gross)
RETURN

' ***************************************************************************
'*                      ALTERNATIVE OUTPUT PAY RATE FIELD:
 '*                          PRINT USING("##.##", PayRate);
' ***************************************************************************
[ErrorPrint]                                            ' Output line for Error Message (invalid SSN's)
      PRINT
      PRINT TAB(10); "ERROR in Social Security #"; EmployeeID$
RETURN


[SummaryOutput]                                                 ' End of Report Line Output
  PRINT
  PRINT TAB(30); "End Of Employee Report"
RETURN

[CloseFile]                                           ' Close ALL Files
  CLOSE #PayRateFile
  CLOSE #EmployeeSocSecFile
  CLOSE #EmployeePayRollFile
RETURN

