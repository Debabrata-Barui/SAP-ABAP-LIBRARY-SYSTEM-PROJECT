*&---------------------------------------------------------------------*
*&  Include           YDB_RECEIVE_BOOK
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  STATUS_1006  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1006 OUTPUT.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.

DATA: CRD(20) TYPE C.

CLEAR: CR_DAT, CR_DAT2.

IF SY-UCOMM = 'BACKWARD'.
  LEAVE TO SCREEN 1001.
ENDIF.

IF SY-UCOMM = 'EXIT'.
  LEAVE TO SCREEN 0.
ENDIF.

IF SY-UCOMM = 'CENCEL'.
  LEAVE TO SCREEN 0.
ENDIF.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1006  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1006 INPUT.
  CLEAR: YEAR, MONTH, DAY.
IF SY-UCOMM = 'OK'.
  IF BK_ID2 IS NOT INITIAL.
    SELECT SINGLE * FROM YDB_GET_BOOK INTO WA_REC2 WHERE GET_ID = BK_ID2 AND STU_ID = STUID.
     IF SY-SUBRC IS INITIAL.
*        WA_REC-GET_ID = BK_ID2.
*        DELETE YDB_GET_BOOK FROM WA_REC.
        WA_REC-GET_ID = WA_REC2-GET_ID.
        WA_REC-STU_ID = WA_REC2-STU_ID.
        WA_REC-BOOK_ID = WA_REC2-BOOK_ID.
        WA_REC-BOOK_NAME = WA_REC2-BOOK_NAME.
        WA_REC-AUTHOR = WA_REC2-AUTHOR.
        WA_REC-ADDITION = WA_REC2-ADDITION.

        CR_DAT2 =  WA_REC2-CRT_DATE.
        YEAR = CR_DAT2+0(4).
        MONTH = CR_DAT2+4(2).
        DAY = CR_DAT2+6(2).
        CONCATENATE DAY MONTH YEAR INTO CRD SEPARATED BY '/'.
        CLEAR: YEAR, MONTH, DAY.

        RET_DATE2 = SY-DATUM.
        YEAR = RET_DATE2+0(4).
        MONTH = RET_DATE2+4(2).
        DAY = RET_DATE2+6(2).
        CONCATENATE DAY MONTH YEAR INTO RET_DATE SEPARATED BY '/'.
     ENDIF.
  ENDIF.
ENDIF.

IF SY-UCOMM = 'RETURN'.
  DELETE FROM YDB_GET_BOOK  WHERE GET_ID = WA_REC-GET_ID.
  CLEAR: WA_REC2,WA_REC.
ENDIF.

ENDMODULE.
