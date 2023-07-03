REM Timothy Lee
REM Programming Logic Winter 2012
REM Timothy Lee
REM Programming Logic
REM Lumber Record Selection 3
REM
REM BUSINESS POINT OF VIEW:
REM The purpose of this program is to produce the total cost and amount due for a customer
REM and the business of a lumber company for different grades and types of wood at
REM different sizes and distances shipped.
REM
REM PERSONAL POINT OF VIEW:
REM The purpose of this program is to combine various techniques for coming up with
REM different values for the same variable.  Using complex, and combined ifs, it is possible
REM to use different values for a particular variable depending on the conditions.  Also
REM record selection is emphisized, as you only process records for certain records.  Practice in Cases.



REM INPUT FIELDS (Takes input from LUMBER.DAT)

Global CustNum             ' Takes input from LUMBER.DAT file
Global ItemNum             ' Takes input from LUMBER.DAT file
Global Length              ' Takes input from LUMBER.DAT file
Global Width               ' Takes input from LUMBER.DAT file
Global Thickness           ' Takes input from LUMBER.DAT file
Global Grade               ' Takes input from LUMBER.DAT file
Global MatType$            ' Takes input from LUMBER.DAT file
Global DistShipped         ' Takes input from LUMBER.DAT file


REM DERIVED VALUES AND CONSTANTS

Global BoardFeet                    ' TotVolume / BOARDFEETCONST
Global CostPBoardFt                 ' CASE embedded IF
Global TotLength                    ' Length / 2
Global TotVolume                    ' TotLenth * Width * Thickness
Global TotMatCost                   ' BoardFeet * CostPBoardft
Global WeightPBoardFt               ' IF statement
Global ShippingWeight               ' BoardFee * WeightPBoardFt
Global ShippingChargePMile          ' If and Nested If Statements
Global TotFreightCharge             ' ShippingChargePMile * DistShipped
Global TotDue                       ' TotMatCost + TotFreightCharge

Global BOARDFEETCONST               ' BOARDFEETCONST = 144


REM PAGINATION FIELDS

Global RecCounter                   ' RecCounter = RecCounter + 1
Global PageNum                      ' PageNum = PageNum + 1
Global TOTRECPPAGE                  ' TOTRECPPAGE = 2




REM LEVEL 1 FLOWCHART PROCESSES/ROUTINES

REM MAINLINE PROCESSES (Housekeeping, Process Records, and End of Job are all subroutines within the MainLine)

GOSUB [HouseKeeping]                ' HouseKeepings job is to open files, initialize vars, one time processes, and priming read

DO WHILE eof(#LUMBER.DAT) = 0       ' As long as the eof switch is set to off(0), loop ProcessRecords
        GOSUB [ProcessRecords]      ' Calling ProcessRecords subroutine
    LOOP
    GOSUB [EndOfJob]                ' Calling EndOfJob to provide the output summary and to close the files
END                                 ' Ending the Program




[HouseKeeping]                    ' HouseKeepings job is to open files, initialize vars, one time processes, and priming read
    GOSUB [OpenFiles]             ' Opens all files the program will use, in this case the field input file
    GOSUB [InitializeVariables]   ' Initializes all variables that need it to an initial value, including constants
'    GOSUB [Headings]              ' Places one time screen prints and headings(Comment out for pagination)
    GOSUB [ReadFile]              ' Places the data of the input field file into the already declared variables using an input field for priming read
RETURN

[ProcessRecords]                  ' Calculates the Commission of each employee and displays it according to the Printer Spacing Chart
    GOSUB [DetailCalculation]     ' Calculates the Commission as COMMISSIONRATE * Sales
    GOSUB [Accumulation]
    GOSUB [WriteDetail]           ' Neatly displays all outputs, and needed info according to the Printer Spacing Chart
    GOSUB [ReadFile]              ' Reads next data record in the input field file
RETURN

[EndOfJob]                        ' Prints the End of the Report and closes the field input file
'    GOSUB [SummaryOutput]
    GOSUB [CloseFiles]            ' Closes the input field file
RETURN





REM LEVEL 2 HOUSEKEEPING ROUTINES

[OpenFiles]                                       ' Opens input field file for use within program
    OPEN "LUMBER.DAT" FOR INPUT AS #LUMBER.DAT    ' Actualy line that opens file for use with #LUMBER.DAT
RETURN


[InitializeVariables]             ' Sets initial values for all parameters/vars/consts that need them
    CustNum = 0                   ' Initialize to Zero.
    ItemNum = 0                   ' Initialize to Zero.
    Length = 0                    ' Initialize to Zero.
    Width = 0                     ' Initialize to Zero.
    Thickness = 0                 ' Initialize to Zero.
    BoardFeet = 0                 ' Initialize to Zero.
    Grade = 0                     ' Initialize to Zero.
    CostPBoardFt = 0              ' Initialize to Zero.
    TotLength = 0                 ' Initialize to Zero.
    TotVolume = 0                 ' Initialize to Zero.
    TotMatCost = 0                ' Initialize to Zero.
    WeightPBoardFt = 0            ' Initialize to Zero.
    DistShipped = 0               ' Initialize to Zero.
    ShippingWeight = 0            ' Initialize to Zero.
    ShippingChargePMile = 0       ' Initialize to Zero.
    TotFreightCharge = 0          ' Initialize to Zero.
    TotDue = 0                    ' Initialize to Zero.
    BOARDFEETCONST = 144          ' Initialize to 144.
    RecCounter = 3                ' Initialize to 3.
    TOTRECPPAGE = 2               ' Initialize to 2.
    PageNum = 0                   ' Initialize to Zero.
RETURN



REM End of Housekeeping Routines

REM LEVEL 2 PROCESS RECORDS ROUTINES

[Pagination]
    PRINT CHR$(12)                  ' Advances the printer to the next page
    PageNum = PageNum + 1           ' Increment Page Number
    GOSUB [Headings]                ' Write the headings for the new page
    RecCounter = 1                  ' Set line counter for new page
RETURN

[Headings]         ' Prints Headings for new page.  Had to think of Something when the new page hit lol.
    PRINT Tab(2); "Assignment #3 W12  IF's Record Selection LUMBER RECEIPT"; Tab(5); "  Page #:"; Tab(6); USING("##", PageNum)
    PRINT " "
    PRINT " "
    PRINT " "
RETURN


[DetailCalculation]                               ' Details the calculations to take place in order to reviece the desired values
    TotLength = Length * 12
    TotVolume = TotLength * Width * Thickness
    BoardFeet = TotVolume / BOARDFEETCONST
    GOSUB [SelectGrade]                           ' The CASE that Calculates CostPBoardFt.
    IF MatType$ = "A" THEN
        WeightPBoardFt = 1.3
    ELSE
        WeightPBoardFt = 1.1
    END IF
    ShippingWeight = BoardFeet * WeightPBoardFt
    GOSUB [ShippingChargePerMile]                 ' The IF statements that calculate ShippingChargePMile
RETURN

[SelectGrade]                           ' Called in Detail Calculation.
    SELECT CASE Grade
        CASE 1
            IF MatType$ = "A" THEN
                CostPBoardFt = 2.25
            ELSE
                CostPBoardFt = 1.08
            END IF
        CASE 2
            IF MatType$ = "A" THEN
                CostPBoardFt = 1.75
            ELSE
                CostPBoardFt = .85
            END IF
        CASE ELSE
            IF MatType$ = "A" THEN
                CostPBoardFt = 1.20
            ELSE
                CostPBoardFt = .65
            END IF
    END SELECT
RETURN

[ShippingChargePerMile]                   ' Called in Detail Calculation.
    IF DistShipped > 37 THEN
        IF ShippingWeight > 20 THEN
            ShippingChargePMile = 5.50
        ELSE
            ShippingChargePMile = 3.55
        END IF
    ELSE
        IF DistShipped <= 37 AND DistShipped > 15 THEN
            IF ShippingWeight > 20 THEN
                ShippingChargePMile = 3.25
            ELSE
                ShippingChargePMile = 1.80
            END IF
        ELSE
            IF ShippingWeight > 20 THEN
                ShippingChargePMile = 2.10
            ELSE
                ShippingChargePMile = 1.25
            END IF
        END IF
    END IF
RETURN


[Accumulation]                                            ' Didn't really need to put any of this in Accumulation but decided to stay consistent with past assignemnts.
    TotMatCost = BoardFeet * CostPBoardFt
    TotFreightCharge = ShippingChargePMile * DistShipped
    TotDue = TotMatCost * TotFreightCharge
RETURN


[WriteDetail]                              ' Prints data and derived values according to the printer spacing chart.
    If RecCounter > TOTRECPPAGE THEN       ' Checks to see if page needs to be advanced.
        GOSUB [Pagination]                 ' Calls Pagination to Print Headings if page is advanced.
    END IF

    PRINT Tab(2); "TIMBERLAND LUMBER RECEIPT FOR 1 ITEM"; Tab(53); "Sold by: Timothy Lee"
    PRINT " "
    PRINT Tab(2); "CUSTOMER NUMBER: "; Tab(19); USING("####", CustNum); Tab(46); "ITEM #:"; Tab(54); USING("####", ItemNum)
    PRINT " "
    PRINT " "
    PRINT Tab(2); "LENGTH:"; Tab(14); USING("###", TotLength); Tab(18); "in inches"
    PRINT Tab(2); "WIDTH:"; Tab(15); USING("##", Width);
    PRINT " "
    PRINT Tab(2); "THICKNESS:"; Tab(15); USING("##.#", Thickness); Tab(45); "BOARD FEET"; Tab(72); USING("###.##", BoardFeet)

    SELECT CASE Grade      ' Case Statement that decides which grade is printed based on the input file.
        CASE 1
            PRINT Tab(2); "GRADE:"; Tab(11); "High"; Tab(45); "COST PER BOARD FOOT"; Tab(74); USING("#.##", CostPBoardFt)
        CASE 2
            PRINT Tab(2); "GRADE:"; Tab(11); "Medium"; Tab(45); "COST PER BOARD FOOT"; Tab(74); USING("#.##", CostPBoardFt)
        CASE ELSE
            PRINT Tab(2); "GRADE:"; Tab(11); "Low"; Tab(45); "COST PER BOARD FOOT"; Tab(74); USING("#.##", CostPBoardFt)
    END SELECT
    PRINT " "
    PRINT " "

    SELECT CASE MatType$   ' Case Statement using a string input deciding which Material Type to Print based on input file.
        CASE "A"
            PRINT Tab(2); "MATERIAL TYPE"; Tab(25); "Plywood"
        CASE ELSE
            PRINT Tab(2); "MATERIAL TYPE"; Tab(25); "Framing Lumber"
    END SELECT

    PRINT Tab(2); "WEIGHT PER BOARD FOOT:"; Tab(30); USING("#.#", WeightPBoardFt); Tab(45); "TOTAL SHIPPING WEIGHT"; Tab(72); USING("###.###", ShippingWeight)
    PRINT " "
    PRINT Tab(2); "DISTANCE: "; USING("##", DistShipped); Tab(45); "SHIPPING CHARGE PER MILE:"; Tab(74); USING("#.##", ShippingChargePMile)
    PRINT " "
    PRINT "============================================================================="
    PRINT Tab(2); "ITEM TOTALS:";       ' Printing totals.  Outside of SummaryOutput because it is not overall and instead for each receipt.
    PRINT " "
    PRINT Tab(11); "TOTAL MATERIAL COST:"; Tab(34); USING("###.##", TotMatCost)
    PRINT Tab(11); "TOTAL FREIGHT CHARGE:"; Tab(33); USING("####.##", TotFreightCharge)
    PRINT Tab(11); "TOTAL AMOUNT DUE:"; Tab(32); "$"; USING("#####.##", TotDue)
    PRINT " "
    PRINT " "
    PRINT " "
    PRINT " "
    PRINT " "
    RecCounter = RecCounter + 1         ' Advances Reccord Counter so Page can be advnaced when needed.
RETURN

REM End of Process Records Routines




REM ReadFile Routine thats both part of HouseKeeping and ProcessRecords

[ReadFile]                                 ' Reads the field input file and places the data into already declared vars
    INPUT #LUMBER.DAT, CustNum, ItemNum, Length, Width, Thickness, Grade, DistShipped, MatType$     ' Taking data from LUMBER.DAT
RETURN




REM LEVEL 2 END OF JOB ROUTINES

'[SummaryOutput]                       ' Prints that the End of the Report has been reached

[CloseFiles]                          ' Closes the LUMBER.DAT file so it doesn't not stay open
    CLOSE #LUMBER.DAT
RETURN
