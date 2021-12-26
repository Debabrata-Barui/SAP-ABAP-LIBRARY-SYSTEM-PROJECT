*&---------------------------------------------------------------------*
*&  Include           YDB_HOME_PAGE
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_1006  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1001 OUTPUT.

 SET PF-STATUS 'MENU1'.
*  SET TITLEBAR 'xxx'.


SELECT SINGLE  NAME FROM YDB_INFO INTO STUNAME WHERE STU_ID = STUID.



IF SY-UCOMM = 'BK'.
  LEAVE TO SCREEN 1000.
ELSEIF SY-UCOMM = 'EXIT'.
  LEAVE TO SCREEN 0.
ELSEIF SY-UCOMM = 'CENCEL'.
  LEAVE TO SCREEN 0.
ENDIF.



*SELECT SINGLE * FROM YDB_GET_BOOK INTO WA_GET2 WHERE STU_ID = STUID.
*  IF SY-SUBRC IS INITIAL.
*     S_ID = WA_GET2-STU_ID.
*     B_ID = WA_GET2-BOOK_ID.
*     B_NAME = WA_GET2-BOOK_NAME.
*     B_AUTHOR = WA_GET2-AUTHOR.
*     B_ADDITION = WA_GET2-ADDITION.
*     CR_DAT = WA_GET2-CRT_DATE.
*  ELSE.
*    CLEAR: B_ID,B_NAME, B_AUTHOR, B_ADDITION, CR_DAT.
*  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1001 INPUT.

IF SY-UCOMM = 'BTN1'.
  LEAVE TO SCREEN 1004.
ENDIF.

IF SY-UCOMM = 'BTN2'.
  LEAVE TO SCREEN 1005.
ENDIF.


IF SY-UCOMM = 'BTN3'.
  LEAVE TO SCREEN 1006.
ENDIF.

IF SY-UCOMM = 'LOGOUT'.
  CLEAR: STUID.
  LEAVE TO SCREEN 1000.
ENDIF.


IF SY-UCOMM = 'SHOW'.
  LEAVE TO SCREEN 1007.
ENDIF.

IF SY-UCOMM = 'UPDAT'.
  LEAVE TO SCREEN 1008.
ENDIF.


ENDMODULE.
