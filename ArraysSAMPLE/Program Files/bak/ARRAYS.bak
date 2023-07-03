REM DO WHILE LOOP

PRINT "DO WHILE LOOP:"
    X = 0
    DO WHILE X < 10
        PRINT X
    X = X + 1
LOOP


REM DO UNTIL LOOP

PRINT "DO UNTIL LOOP"
    X = 0
    DO UNTIL X = 10
        PRINT X
    X = X + 1
    LOOP


REM FOR NEXT LOOP

PRINT "FOR NEXT LOOP"
    FOR X = 0 TO 10
    PRINT X
    NEXT


REM Make and Array

DIM arrayStudName(9)

PRINT
PRINT "ARRAY LOAD VALUES: "

FOR X = 0 TO 9
    arrayStudName(X) = (X + 10)
'    PRINT X, arrayStudName(X)
NEXT

PRINT
PRINT "LOOP TO DISPLAY ARRAY VALUES:"

FOR X = 0 TO 9
    PRINT X, arrayStudName(X)
NEXT

PRINT
PRINT "LOAD AN OUTPUT FROM DATA FILE WITH DEFINITE ITERATION"
OPEN "ArrayData.dat" FOR INPUT AS #ArrayDataFile

FOR SUBSCRIPT = 0 TO 9
    INPUT #ArrayDataFile, InputData
    arrayStudName(SUBSCRIPT) = InputData
NEXT

FOR SUBSCRIPT = 0 TO 9
    PRINT SUBSCRIPT, arrayStudName(SUBSCRIPT)
NEXT

CLOSE #ArrayDataFile


PRINT
PRINT "LOAD AN OUTPRUT FROM DATA FILE WITH INDEFINITE ITERATION"

DIM numbersArray$(20)     ' Create the Array

OPEN "ArrayDataTWO.dat" FOR INPUT AS #ArrayDataFile ' Open Data File to Load
SUBSCRIPT = 0
INPUT #ArrayDataFile, InputData$
DO WHILE EOF(#ArrayDataFile) = 0
    numbersArray$(SUBSCRIPT) = InputData$
    INPUT #ArrayDataFile, InputData$
    SUBSCRIPT = SUBSCRIPT + 1
LOOP

NumOfElements = SUBSCRIPT
PRINT "Number of Elements is: "; NumOfElements; "     SUBSCRIPTS WILL BE 0 THRU "; NumOfElements - 1

FOR SUBSCRPT = 0 TO NumOfElements - 1   ' This Tests for >
    PRINT SUBSCRPT, numbersArray$(SUBSCRPT)
NEXT

PRINT "DIRECT RELATIONSHIP OUTPUT:"
PRINT "DIRECT RELATIONSHIP OUTPUT OF NAME AND AGE TYPED OUT IN WORDS"
PRINT

OPEN "NameAge.dat" FOR INPUT AS #NameAge

DO WHILE EOF(#NameAge) = 0
    INPUT #NameAge, Name$, Age
    PRINT Name$; " IS "; numbersArray$(Age)
LOOP

CLOSE #NameAge

CLOSE #ArrayDataFile


