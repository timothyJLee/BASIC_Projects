
REM Timothy Lee
REM Programming Logic WINTER 2012
REM Detail Calculations with Totals, Averages, Record Selection and Pagination
REM
REM BUSINESS POINT OF VIEW:
REM     The Purpose of this Program is to Calculate the final grades of a list of Students.
REM     Using the information given, various values must be manipulated and calculated, and
REM     eventually printed into a report.  Schools need to do things like this on a regular
REM     basis just using the information given.  It is useful for determining various things
REM     about the school, the student body, individual students and classes, and the whole
REM     system as a whole.
REM
REM PERSONAL POINT OF VIEW:
REM     This program introduces a few uses for an IF statement.  It makes individual record
REM     selection and recognition an important thing to know how to do.  Again, totals and
REM     averages are expected and knowing what modules to put them in.  This is the first
REM     assignment to require pagination, which also requires and IF statement.



REM INPUT FIELDS (Takes input from GradePtsFile.txt)

Global Name$                    ' Student Name
Global CourseID1$               ' The ID number for the first course taken
Global CourseID2$               ' The ID number for the second course taken
Global CreditHrs1               ' The number of credit hours for the first course
Global CreditHrs2               ' The number of credit hours for the second course
Global Grade1                   ' The grade recieved for the first course
Global Grade2                   ' The grade recieved for the second course


REM No Constants to Declare

REM Calculated/Derived values/vars/fields

Global GrdPnts1         ' Grade Points for the first course derived from two inputs
Global GrdPnts2         ' Grade Points for the second course derived from two inputs
Global SumGrdPnts       ' The sum of the grade points for both courses taken
Global SumCreditHrs     ' The sum of the credit hours given for each course
Global GPA              ' The Grade Point Average for the two courses

Global TotStudents      ' The total number of Students
Global TotCreditHrs     ' The total number of Credit Hours
Global TotGrdPnts       ' The total number of Grade Points
Global OverallGPA       ' The Overall GPA of all the students

Global LineCounter      ' Declare Pagination Field
Global PageSize         ' Declare Pagination Field
Global PageNum          ' Declare Pagination Field




REM MAINLINE PROCESSES (Housekeeping, Process Records, and End of Job are all subroutines within the MainLine)

GOSUB [HouseKeeping]                ' HouseKeepings job is to open files, initialize vars, one time processes, and priming read

DO WHILE eof(#GradePtsFile.txt) = 0 ' As long as the eof switch is set to off(0), loop ProcessRecords
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

[ProcessRecords]                               ' Calculates the Commission of each employee and displays it according to the Printer Spacing Chart
    IF Grade1 <> 0.0 AND Grade2 <> 0.0 THEN    ' If Statement that skips Process Records for incorrect records
        GOSUB [DetailCalculation]              ' Calculates all the derived values
        GOSUB [Accumulation]                   ' Calculates the totals and averages over the course of the program
        GOSUB [WriteDetail]                    ' Neatly displays all outputs, and needed info according to the Printer Spacing Chart
        GOSUB [ReadFile]                       ' Reads next data record in the input field file
     ELSE
        GOSUB [ReadFile]
    END IF
RETURN

[EndOfJob]                        ' Prints the End of the Report and closes the field input file
    GOSUB [SummaryOutput]         ' Prints "end of report"
    GOSUB [CloseFiles]            ' Closes the input field file
RETURN






REM LEVEL 2 HOUSEKEEPING ROUTINES

[OpenFiles]                                                 ' Opens input field file for use within program
    OPEN "GradePtsFile.txt" FOR INPUT AS #GradePtsFile.txt  ' Actual line that opens file for use with #GrdPts.txt
RETURN


[InitializeVariables]         ' Sets initial values for all parameters/vars/consts that need them
    GrdPnts1 = 0              ' Initialize to 0
    GrdPnts2 = 0              ' Initialize to 0

    SumGrdPnts = 0            ' Initialize to 0
    SumCreditHrs = 0          ' Initialize to 0

    GPA = 0                   ' Initialize to 0
    OverallGPA = 0            ' Initialize to 0

    TotStudents = 0           ' Initialize to 0
    TotCreditHrs = 0          ' Initialize to 0
    TotGrdPnts = 0            ' Initialize to 0

    LineCounter = 99          ' Pagination Field
    PageSize = 20             ' Pagination Field # of lines printed per page
    PageNum = 0               ' Pagination Field 0 will be incremented
RETURN

REM END OF HOUSEKEEPING ROUTINES



REM LEVEL 2 PROCESS RECORDS ROUTINES




[DetailCalculation]                          ' Details the calculations to take place in order to receive the desired values
    GrdPnts1 = CreditHrs1 * Grade1           ' Detail Calculation for Grade Points 1
    GrdPnts2 = CreditHrs2 * Grade2           ' Detail Calculations for Grade Points 2

    SumGrdPnts = GrdPnts1 + GrdPnts2         ' Detail Calculation for the sum of the Grade Points
    SumCreditHrs = CreditHrs1 + CreditHrs2   ' Detail Calculation for the sum of the Credit Hours
    GPA = SumGrdPnts / SumCreditHrs          ' Detail Calculation for the Grade Point Average
RETURN


[Accumulation]                                  ' Calculates totals and averages
    TotStudents = TotStudents + 1               ' Total Students, Adjusted later to not count extra entries
    TotCreditHrs = TotCreditHrs + SumCreditHrs  ' Total Credit Hours from all students
    TotGrdPnts = TotGrdPnts + SumGrdPnts        ' Total Grade Points from all the students
    OverallGPA = TotGrdPnts / TotCreditHrs      ' The overall GPA of all the students
RETURN


[WriteDetail]                          ' Prints items according to printer spacing chart
    IF LineCounter >= PageSize THEN    ' Decides whether or not to call pagination to advance the page
        GOSUB [Pagination]
    ELSE
        PRINT Tab(2); Name$; Tab(16); CourseID1$; Tab(25); USING("#", CreditHrs1); Tab(30); USING("#.#", Grade1); Tab(36); USING("##.#", GrdPnts1); Tab(42); CourseID2$; Tab(52); USING("#", CreditHrs2); Tab(57); USING("#.#", Grade2); Tab(63); USING("##.#", GrdPnts2); Tab(74); USING("#.##", GPA)
        LineCounter = LineCounter + 1  ' Incrementing the line counter for use with pagination
    END IF
RETURN


[Pagination]
    PRINT CHR$(12)                 ' Advances the printer to the next page
    PageNum = PageNum + 1          ' Increment Page Number
    GOSUB [Headings]               ' Write the headings for the new page
    LineCounter = 1                ' Set line counter for new page
RETURN

[Headings]   ' Prints the Headings According to the Printer Spacing Chart
    PRINT Tab(21); "STUDENT GRADE REPORT"; Tab(70); "Page:"; Tab(76); USING("###", PageNum)
    PRINT Tab(21); "By:  Timothy Lee"
    PRINT " "
    PRINT Tab(2); "Student"; Tab(16); "Course"; Tab(24); "Cr."; Tab(35); "Grade"; Tab(42); "Course"; Tab(51); "Cr."; Tab(62); "Grade"; Tab(70); "Grade Pt."
    PRINT Tab(2); "Name"; Tab(16); "ID #1"; Tab(24); "Hrs"; Tab(29); "Grade"; Tab(37); "Pts"; Tab(42); "ID #2"; Tab(51); "Hrs"; Tab(56); "Grade"; Tab(64); "Pts"; Tab(71); "Average"
    PRINT " "
RETURN

REM END OF PROCESS RECORDS ROUTINES




[ReadFile]                                 ' Reads the field input file and places the data into already declared vars
    INPUT #GradePtsFile.txt, Name$, CourseID1$, CreditHrs1, Grade1, CourseID2$, CreditHrs2, Grade2     ' Taking data from GradePtsFile.txt
RETURN





REM LEVEL 2 END OF JOB ROUTINES

[SummaryOutput]           ' Prints the accumulated totals and averages on their respective lines.
    PRINT " "
    PRINT Tab(2); "FINAL TOTALS:"
    PRINT " "
    PRINT Tab(6); "Total Number of Students"; Tab(47); USING("##", TotStudents - 3)
    PRINT " "
    PRINT Tab(6); "Total of all Credit Hours"; Tab(46); USING("###", TotCreditHrs)
    PRINT Tab(6); "Total of all Earned Grade Points"; Tab(46); USING("###.#", TotGrdPnts)
    PRINT " "
    PRINT Tab(6); "Final Grade Point Average"; Tab(48); USING("##.###", OverallGPA)
RETURN


[CloseFiles]                          ' Closes the GradePtsFile.txt file so it doesn't not stay open
    CLOSE #GradePtsFile.txt
RETURN

