*&---------------------------------------------------------------------*
*&  Include           YDB_GET_BOOK
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  STATUS_1005  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1005 OUTPUT.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.

DATA: GG_BOOK TYPE YDB_GET_BOOK.

IF SY-UCOMM = 'BACKWARD'.
  LEAVE TO SCREEN 1001.
ELSEIF SY-UCOMM = 'EXIT'.
  LEAVE TO SCREEN 0.
ELSEIF SY-UCOMM = 'CENCEL'.
  LEAVE TO SCREEN 0.
ENDIF.
*CLEAR: WA_GET, BK_ID, B_ID, B_NAME, B_AUTHOR, B_ADDITION, CR_DAT2, STUID, CR_DAT, GET_ID2.

 SELECT MAX( GET_ID ) FROM YDB_GET_BOOK INTO GET_ID2.





ENDMODULE.



*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1005  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1005 INPUT.

IF SY-UCOMM = 'GET'.
  SELECT SINGLE * FROM YDB_GET_BOOK INTO GG_BOOK WHERE STU_ID = STUID.
  IF GG_BOOK IS NOT INITIAL.
    IF GG_BOOK-BOOK_ID = BK_ID.
      MESSAGE 'THE BOOK ALREADY EXISTS TO YOU' TYPE 'E'.
    ELSE.
      PERFORM GT_BOOK.
    ENDIF.
  ELSE.
   PERFORM GT_BOOK.
  ENDIF.
ENDIF.
ENDMODULE.




FORM GT_BOOK.
    IF BK_ID IS NOT INITIAL.
       SELECT SINGLE * FROM YDB_BOOK_INFO INTO CORRESPONDING FIELDS OF WA_BOOK3
       WHERE BOOK_ID = BK_ID.
      S_ID = STUID.
      B_ID = WA_BOOK3-BOOK_ID.
      B_NAME = WA_BOOK3-BOOK_NAME.
      B_AUTHOR = WA_BOOK3-AUTHOR.
      B_ADDITION = WA_BOOK3-ADDITION.
      CR_DAT2 = SY-DATUM.

      YEAR = CR_DAT2+0(4).
      MONTH = CR_DAT2+4(2).
      DAY = CR_DAT2+6(2).

      CONCATENATE DAY MONTH YEAR INTO CR_DAT SEPARATED BY '/'.
      CLEAR: YEAR, MONTH, DAY.

      WA_GET-MANDT = SY-UNAME.
      WA_GET-GET_ID = GET_ID2 + 1.
      WA_GET-STU_ID = S_ID.
      WA_GET-BOOK_ID = B_ID.
      WA_GET-BOOK_NAME = B_NAME.
      WA_GET-AUTHOR = B_AUTHOR.
      WA_GET-ADDITION = B_ADDITION.
      WA_GET-CRT_DATE = CR_DAT2.

      INSERT YDB_GET_BOOK FROM WA_GET.

*      CLEAR: WA_GET, BK_ID, B_ID, B_NAME, B_AUTHOR, B_ADDITION, CR_DAT2, STUID.

    ENDIF.
ENDFORM.
