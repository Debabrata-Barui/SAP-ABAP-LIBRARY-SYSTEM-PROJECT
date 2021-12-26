
MODULE STATUS_1004 OUTPUT.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.

*IF SY-UCOMM = 'BACK'.
*  LEAVE TO SCREEN '1001'.
*ELSEIF SY-UCOMM = 'EXIT'.
*  LEAVE TO SCREEN 0.
*ELSEIF SY-UCOMM = 'CENCEL'.
*  LEAVE TO SCREEN 0.
*ENDIF.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1004  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1004 INPUT.

IF SY-UCOMM = 'BACKWARD'.
  LEAVE TO SCREEN 1001.
ELSEIF SY-UCOMM = 'EXIT'.
  LEAVE TO SCREEN 0.
ELSEIF SY-UCOMM = 'CENCEL'.
  LEAVE TO SCREEN 0.
ENDIF.


ENDMODULE.


INCLUDE YDB_BOOK_TBL.


*&---------------------------------------------------------------------*
*&      Module  OUTPUT  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE OUTPUT OUTPUT.

SELECT * FROM YDB_BOOK_INFO INTO CORRESPONDING FIELDS OF TABLE IT_BOOK.
IF SY-UCOMM = 'SEARCH'.
 IF WA_BOOK IS NOT INITIAL.
     SELECT * FROM YDB_BOOK_INFO INTO CORRESPONDING FIELDS OF TABLE IT_BOOK
     WHERE BOOK_NAME = WA_BOOK-BOOK_NAME OR AUTHOR = WA_BOOK-AUTHOR.
 ENDIF.
 ELSE.
   SELECT * FROM YDB_BOOK_INFO INTO CORRESPONDING FIELDS OF TABLE IT_BOOK.
 ENDIF.
ENDMODULE.
