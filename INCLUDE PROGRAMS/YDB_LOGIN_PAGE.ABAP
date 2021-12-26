*&---------------------------------------------------------------------*
*&  Include           YDB_LOGIN_PAGE
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  STATUS_1001  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1000 OUTPUT.
  SET PF-STATUS 'MENU'.
*  SET TITLEBAR 'xxx'.




CLEAR: WA_LOGIN2, WA_LOGIN, MSG.



ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1000 INPUT.
IF SY-UCOMM = 'LOGIN'.
  IF WA_LOGIN IS NOT INITIAL.
   SELECT SINGLE * FROM YDB_LOGIN INTO CORRESPONDING FIELDS OF WA_LOGIN2
     WHERE USERID = WA_LOGIN-USERID AND PASSWORD = WA_LOGIN-PASSWORD.

    IF SY-SUBRC IS INITIAL.

*      MESSAGE 'SUCCESS' TYPE 'S'.
      STUID = WA_LOGIN2-STU_ID.
      IF STUID IS NOT INITIAL.
        LEAVE TO SCREEN 1001.
      ENDIF.
    ENDIF.
 ELSE.
   MSG = 'ENTER THE CURRECT VALUE'.
 ENDIF.

ENDIF.

IF SY-UCOMM = 'NEW'.
  LEAVE TO SCREEN 1002.

ENDIF.





CLEAR: WA_LOGIN, WA_LOGIN2.
ENDMODULE.
