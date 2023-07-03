REM Timothy Lee
REM Programming Logic Winter 2012
REM Sales by Department in Store by District.  Multiple Control Break Example
REM
REM BUSINESS POINT OF VIEW:
REM The Purpose of the Program is to break down sales data into more specific Accumulations in order to gather
REM information about how various areas of a business are functioning and operating.
REM
REM PERSONAL POINT OF VIEW:
REM The purpose of the program is to give an example of the usefulness of Control Breaks.  It teaches how to
REM accumulate subtotals by department, store, and district, as well as overall totals.


REM INPUT FIELDS(Takes input from CBmultiple.dat):

Global District
Global StoreNum
Global Dept$
Global SalesPerson$
Global Sales

REM Control Break Testing Fields:

Global PrevDept$
Global PrevStoreNum
Global PrevDistrict

REM Accumulation Fields:

Global TotDept
Global TotStore
Global TotDistrict
Global TotFinal

REM Pagination Fields:

Global LineCounter
Global PageSize
Global PageNum


REM LEVEL 1 FLOWCHART PROCESSES/ROUTINES

REM MAINLINE PROCESSES (Housekeeping, Process Records, and End of Job are all subroutines within the MainLine)

GOSUB [HouseKeeping]
    DO WHILE eof(#Sales) = 0       ' As long as the eof switch is set to off(0), loop ProcessRecords
        GOSUB [ProcessRecords]
    LOOP
    GOSUB [EndOfJob]               ' Ending the Program
END

[HouseKeeping]                     ' HouseKeepings job is to open files, initialize vars, one time processes, and priming read
    GOSUB [InitializeVariables]    ' Initializes all variables that need it to an initial value, including constants
    GOSUB [OpenFiles]              ' Opens all files the program will use, in this case the field input file
    GOSUB [ReadFile]               ' Places the data of the input field file into the already declared variables using an input field for priming read
    GOSUB [PrevDeptSetup]          ' Sets up Control Break fields for next Department
    GOSUB [PrevStoreSetup]         ' Sets up Control Break fields for next Store
    GOSUB [PrevDistSetup]          ' Sets up Control Break fields for next District
RETURN

[ProcessRecords]                   ' Calculates the Commission of each employee and displays it according to the Printer Spacing Chart
    GOSUB [ControlBreakCheck]      ' Checks to see if Control Breaks need to be performed
    GOSUB [Accumulation]           ' Accumulates the Total Sales for the Department
    GOSUB [DetailOutput]           ' Neatly displays all outputs, and needed info according to the Printer Spacing Chart
    GOSUB [ReadFile]               ' Reads next data record in the input field file
RETURN

[EndOfJob]                         ' Prints the End of the Report and closes the field input file
    GOSUB [SummaryOutput]
    GOSUB [CloseFiles]             ' Closes the input field file
RETURN



REM LEVEL 2 HOUSEKEEPING ROUTINES

[InitializeVariables]             ' Sets initial values for all parameters/vars/consts that need them
    TotDept = 0
    TotStore = 0
    TotDistrict = 0
    TotFinal = 0

    PageSize = 20
    LineCounter = PageSize + 1    ' Sets LineCounter to one More than PageSize so Headings will Print on first Page
    PageNum = 0
RETURN


[OpenFiles]                       ' Opens CBmultiple.dat for use within program
    OPEN "CBmultiple.dat" FOR INPUT AS #Sales
RETURN


[PrevDeptSetup]                   ' Sets up Control Break fields for next Department
    PrevDept$ = Dept$
RETURN


[PrevStoreSetup]                  ' Sets up Control Break fields for next Department
    PrevStoreNum = StoreNum
RETURN


[PrevDistSetup]                   ' Sets up Control Break fields for next Department
    PrevDistrict = District
RETURN

REM End of Housekeeping Routines



REM LEVEL 2 PROCESS RECORDS ROUTINES

[ControlBreakCheck]                               ' Checks to see if Control Breaks need to be performed
    IF District <> PrevDistrict THEN              ' Prints all Control Breaks
        PRINT
            GOSUB [TotDeptOutput]
            GOSUB [TotStoreOutput]
            GOSUB [TotDistOutput]
        PRINT
        PRINT
        LineCounter = LineCounter + 6             ' Line Counter for printed lines
    ELSE
        IF StoreNum <> PrevStoreNum THEN          ' Prints two Control Breaks
            PRINT
                GOSUB [TotDeptOutput]
                GOSUB [TotStoreOutput]
            PRINT
            LintCounter = LineCounter + 4         ' Line Counter for printed lines
        ELSE
            IF Dept$ <> PrevDept$ THEN            ' Prints one Control Break
                PRINT
                    GOSUB [TotDeptOutput]
                PRINT
                LineCounter = LineCounter + 3     ' Line Counter for printed lines
            END IF
        END IF
    END IF
RETURN


[Accumulation]                         ' Accumulates the sales for the current department
    TotDept = TotDept + Sales
RETURN


[DetailOutput]                         ' Neatly displays all outputs, and needed info according to the Printer Spacing Chart
    IF LineCounter > PageSize THEN     ' Checks to see if the page needs to be advanced
        GOSUB [Headings]               ' Prints Headings upon page advance
    END IF
    PRINT USING("###", District); Tab(12); USING("##", StoreNum); Tab(24); Dept$; Tab(38); SalesPerson$; Tab(59); USING("###.##", Sales)
    LineCounter = LineCounter + 1      ' Incrementing the LineCounter
RETURN


[Headings]                             ' Places one time screen prints and headings
    PRINT CHR$(12)
    PageNum = PageNum + 1
    PRINT Tab(24); "Sales Report"; Tab(56); "Page  #"; Tab(56); USING("##", PageNum)
    PRINT
    PRINT "DISTRICT"; Tab(12); "STORE"; Tab(24); "DEPT"; Tab(38); "SALESPERSON"; Tab(56); "DAILY SALES"
    PRINT
    LineCounter = 4                    ' Resets the LineCounter to # after headings print
RETURN


REM End of Process Records Routines



REM ReadFile Routine thats both part of HouseKeeping and ProcessRecords

[ReadFile]                                 ' Reads the field input file and places the data into already declared vars
    INPUT #Sales, District, StoreNum, Dept$, SalesPerson$, Sales     ' Taking data from CBmultiple.dat
RETURN



REM Control Break Processing Routines in Output Order

[TotDeptOutput]            ' Prints Total Department Output upon Control Break
    PRINT Tab(24); "TOTAL FOR DEPT "; PrevDept$; Tab(56); "$"; USING("#####.##", TotDept)
    TotStore = TotStore + TotDept  ' Accumulating Totals
    TotDept = 0                    ' Reset for next Control Break
    GOSUB[PrevDeptSetup]           ' Setup Control Break
RETURN


[TotStoreOutput]           ' Prints Total Store Output upon Control Break
    PRINT Tab(24); "TOTAL FOR STORE "; USING("##", PrevStoreNum); Tab(56); "$"; USING("#####.##", TotStore)
    TotDistrict = TotDistrict + TotStore   ' Accumulating Totals
    TotStore = 0                           ' Reset for next Control Break
    GOSUB [PrevStoreSetup]                 ' Setup Control Break
RETURN


[TotDistOutput]            ' Prints Total District Output upon Control Break
    PRINT Tab(24); "TOTAL FOR DISTRICT "; USING("###", PrevDistrict); Tab(56); "$"; USING("#####.##", TotDistrict)
    TotFinal = TotFinal + TotDistrict     ' Accumulating Totals
    TotDistrict = 0                       ' Reset for next Control Break
    GOSUB [PrevDistSetup]                 ' Setup Control Break
RETURN


REM End Control Break Processing Routines



REM End of Jobs Routines

[SummaryOutput]             ' Prints that the End of the Report has been reached and Overall Totals
    PRINT
    GOSUB[TotDeptOutput]    ' Final Outputs
    GOSUB[TotStoreOutput]   ' Final Outputs
    GOSUB[TotDistOutput]    ' Final Outputs
    PRINT
    PRINT
    PRINT Tab(24); "FINAL TOTAL ALL DISTRICTS"; Tab(56); "$"; USING("#####.##", TotFinal)
RETURN

[CloseFiles]        ' Closes the CBmultiple.dat file so it doesn't not stay open
    CLOSE #Sales
RETURN
