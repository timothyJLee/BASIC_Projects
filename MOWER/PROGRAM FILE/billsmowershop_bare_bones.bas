'  Program Name: Chapter 4 DECISIONS: Repair Report for Bill's Lawnmower Shop
'  Programmer: Logic class Winter 2012
'  Purpose from Class POV:  Conditions with IF (then convert to CASE)and
'                        Greater Modularity Usage
'                Record Selection Processes are also introduced
'  Purpose from Business POV: Create a billing report for Bill on the
'  types of lawnmowers he chooses for the week. Charges are based upon type of
'  mower for the charge per minute and number of minutes

' Input Fields:



' Constants Minute Charge based upon Mower Type:
 
 
 
 
' Logical Fields/Switches:


'Derived Field:


' and based upon input MOWERCODE



' Output Fields:
'      

GOSUB [StartUp]                ' Mainline Processes
DO WHILE eof(#1) = 0
     GOSUB [ProcessRecords]
LOOP
GOSUB [WrapUp]
END

[StartUp]                        ' One Time Start Up Processes
  GOSUB [OpenFiles]
  GOSUB [Initialize]
  GOSUB [WriteHeadings]
  GOSUB [ReadFile]
RETURN

[ProcessRecords]                ' Processing for each record read


     GOSUB [DetailCalculation]
     GOSUB [WriteDetail]

     GOSUB [ReadFile]                      ' skip & just read next record
RETURN

[WrapUp]                            ' Final, One Time Processes
  GOSUB [SummaryOutput]
  GOSUB [CloseFiles]
RETURN

[OpenFiles]                            ' Input data file is opened for use
  OPEN "MOWERDATA.DAT" FOR INPUT AS #1
RETURN


[Initialize]





RETURN

[WriteHeadings]
  PRINT TAB(30); "BILL'S LAWNMOWER SHOP"            'Report Header
  PRINT TAB(29); "CUSTOMER BILLING REPORT"
  PRINT
  PRINT TAB(4); "TAG.#"; TAB(12); "CUSTOMER";        'Column Header
  PRINT TAB(23); "LAWNMOWER CODE"; TAB(40); "RATE";
  PRINT TAB(47); "REPAIR TIME(MIN)"; TAB(67); "CHARGE"
  PRINT
RETURN

[ReadFile]


RETURN

[RecordSelection]  'Record Selection Test-hardcoded(ideally #'s input by user)



RETURN

[DetailCalculation]
 
 
 
    CHARGE = TIME * RATE          ' Calculation for Total Customer Charge
RETURN

[SelectRate]                     'CONDITIONS TO SET 'CENTS PER MINUTE' RATE



RETURN


[WriteDetail]
                        '  detail output line data & formats:
    PRINT TAB(6); USING ("###",TAGNO$);
    PRINT TAB(12); CUSTOMER$;
    PRINT TAB(31); MOWERCODE;
    PRINT TAB(40); USING("#.##", RATE);
    PRINT TAB(55); USING("###", TIME);
    PRINT TAB(68); USING ("##.##", CHARGE)
    PRINT
 RETURN

[SummaryOutput]
    PRINT TAB(33); "END OF MOWER REPORT"       ' End of report message
RETURN

[CloseFiles]                    ' Close Input File
  CLOSE #1
RETURN
