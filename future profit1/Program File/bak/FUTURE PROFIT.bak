REM Timothy Lee
REM PROGRAMMING LOGIC Class Winter 2012
REM Future Profit Assignment #1
REM
REM BUSINESS POINT OF VIEW:
REM     The purpose of this program is to calculate the profit made from various items sold
REM     for at a marked up value from the Whole Sale Price at a Furniture Store.  Profit is
REM     the purpose of most business, and being at to calculate profit reports rapidly can
REM     help the function of any business.
REM
REM PERSONAL POINT OF VIEW:
REM     This program is the first non-sample program of the class.  Its purpose is to help
REM     us use the various techniques we've learned through the sample program process, and
REM     apply them on our own.  This includes the entire process of writing a program from
REM     start to finish.


REM ***************Var Declaration****************

REM Input Fields from FURNIT.DAT

Global StockNum$              ' Declaring input field to be used with FURNIT.DAT
Global Description$           ' Declaring input field to be used with FURNIT.DAT
Global WholeSalePrice         ' Declaring input field to be used with FURNIT.DAT

REM Declaring Constants

Global MARKUPPERCENT         ' Declaring constant to be initialized to a value later

REM Calculated Values

Global MarkupAmount        ' MarkupAmount = WholeSalePrice * MARKUPPERCENT
Global RetailPrice         ' RetailPrice = WholeSalePrice + MarkupAmount
Global Profit              ' Profit = RetailPrice - WholeSalePrice
Global TotProfit           ' TotProfit = TotProfit + Proft






REM LEVEL 1 FLOWCHAR PROCESSES/ROUTINES


REM MAINLINE PROCESSES (Housekeeping, Process Records, and End of Job are all subroutines within the MainLine)

GOSUB [HouseKeeping]                ' HouseKeepings job is to open files, initialize vars, one time processes, and priming read

DO WHILE eof(#FURNIT) = 0           ' As long as the eof switch is set to off(0), loop ProcessRecords
        GOSUB [ProcessRecords]      ' Calling ProcessRecords subroutine
    LOOP
    GOSUB [EndOfJob]                ' Calling EndOfJob to provide the output summary and to close the files
END                                 ' Ending the Program



[HouseKeeping]                    ' HouseKeeping prepares the program for its run and does a priming read
    GOSUB [OpenFiles]             ' Opens FUNRIT.DAT to be used with the input fields
    GOSUB [InitializeVariables]   ' Initializes the constant value and then initializes derived values to zero
    GOSUB [WriteHeadings]         ' Writes the Headings that Describe the input fields that are printed
    GOSUB [ReadFile]              ' Prepares the input fields to be used with the data file
RETURN

[ProcessRecords]                  ' Does all the calculations needed for the program and Prints them.  Then Prepares the next read on the data file
    GOSUB [DetailCalculation]     ' Calculates the Derived Values
    GOSUB [Accumulation]          ' Calculates the Totals
    GOSUB [WriteDetail]           ' Prints the derived values on the page
    GOSUB [ReadFile]              ' Prepares the next input from the data file
RETURN

[EndOfJob]                        ' Prints totals and closes files
    GOSUB [SummaryOutput]         ' Prints Totals
    GOSUB [CloseFiles]            ' Closes FURNIT.DAT
RETURN





REM LEVEL 2 FLOWCHART HOUSEKEEPING SUBROUTINES

[OpenFiles]
    OPEN "FURNIT.DAT" FOR INPUT AS #FURNIT     ' Opens the data file to be used with the input fields
RETURN

[InitializeVariables]                          ' Initializes constants and variables
    MARKUPPERCENT = .12                        ' CONSTANT

    MarkupAmount = 0                           ' Derived Value
    RetailPrice = 0                            ' Derived Value
    Profit = 0                                 ' Derived Value
    TotProfit = 0                              ' Derived Value(Accumulation)
RETURN

[WriteHeadings]                                                ' Writes Headings at the top of the Page
    PRINT Tab(19); "Profits Report for COMFORTS FURNITURE"     ' Title
    PRINT " "
    PRINT Tab(33); "Timothy Lee"                               ' My Name
    PRINT " "
    PRINT " "
    PRINT Tab(30); "Stock"; Tab(41); "WholeSales"; Tab(55); "Markup"                       ' Headings
    PRINT Tab(3); "Description"; Tab(30); "Number"; Tab(44); "Amount"; Tab(55); "Amount"   ' Headings
    PRINT " "
RETURN




REM LEVEL 2 PROCESS RECORDS SUBROUTINES

[DetailCalculation]                                ' Module that calculates the derived values
    MarkupAmount = WholeSalePrice * MARKUPPERCENT  ' Markup Amount
    RetailPrice = WholeSalePrice + MarkupAmount    ' Retail Price
    Profit = RetailPrice - WholeSalePrice          ' Proft
RETURN

[Accumulation]                                     ' Calculates all the accumulates values
    TotProfit = TotProfit + Profit                 ' Calculates the Total Profit from all sales
RETURN

[WriteDetail]                                ' Prints the Details of the Calculations according to the printer spacing chart
    PRINT Tab(3); Description$; Tab(30); StockNum$; Tab(42); "$"; Tab(43); USING("####.##", WholeSalePrice); Tab(54); "$"; Tab(55); USING("###.##", MarkupAmount)
    PRINT " "
RETURN




REM HOUSEKEEPING AND PROCESSRECORDS SUBROUTINES

[ReadFile]                                                 ' Reads the input field file
    INPUT #FURNIT, StockNum$, Description$, WholeSalePrice ' Preparing a record in FURNIT.DAT to be used with the input fields
RETURN





REM LEVEL 2 END OF JOB ROUTINES

[SummaryOutput]              ' Outputs the accumulated values at the end of the report
    PRINT " "
    PRINT " "
    PRINT Tab(11); "Total Profit:"; Tab(25); "$"; Tab(26); USING("###.##", TotProfit)    ' Prints the Total Profit
    PRINT " "
    PRINT " "
    PRINT Tab(18); "END OF COMFORTS FURNITURE PROFITS REPORT"                            ' Ends the Furniture Profit Report
RETURN

[CloseFiles]         ' Closes all files opened and used in the program
    CLOSE #FURNIT    ' Closes FURNIT.DAT
RETURN
