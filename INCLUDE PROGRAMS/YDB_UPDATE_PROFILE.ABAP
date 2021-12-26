*&---------------------------------------------------------------------*
*&  Include           YDB_UPDATE_PROFILE
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_1008  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1008 OUTPUT.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.


DATA: IT_UPDAT TYPE TABLE OF YDB_INFO,
      WA_UPDAT TYPE YDB_INFO.



DATA: UP_ROLL     TYPE  YDB_ROLL,
      UP_NAME     TYPE  YDB_NAME,
      UP_GENDER   TYPE  YDB_GENDER,
      UP_DEGREE    TYPE  YDB_DEGREE,
      UP_FIELD    TYPE  YDB_FIELD,
      UP_SESS      TYPE  YDB_SESS,
      UP_ADDRESS  TYPE YDB_ADD,
      UP_DATE_AND_TIME TYPE  YDB_DT.


SELECT * FROM YDB_INFO INTO TABLE IT_UPDAT WHERE STU_ID = STUID.

LOOP AT IT_UPDAT INTO WA_UPDAT.
   UP_ROLL   = WA_UPDAT-ROLL.
   UP_NAME   = WA_UPDAT-NAME.
   UP_GENDER = WA_UPDAT-GENDER.
   UP_DEGREE = WA_UPDAT-DEGREE.
   UP_FIELD  = WA_UPDAT-FIELD.
   UP_SESS   = WA_UPDAT-SESS.
   UP_ADDRESS = WA_UPDAT-ADDRESS.
   UP_DATE_AND_TIME = WA_UPDAT-DATE_AND_TIME.
ENDLOOP.

IF SY-UCOMM = 'BACKWARD'.
  LEAVE TO SCREEN 1001.
ELSEIF SY-UCOMM = 'EXIT'.
  LEAVE TO SCREEN 0.
ELSEIF SY-UCOMM = 'CENCEL'.
  LEAVE TO SCREEN 0.
ENDIF.



ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1008  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1008 INPUT.
IF SY-UCOMM = 'UPD'.
  WA_UPDAT-ROLL   = UP_ROLL   .
  WA_UPDAT-NAME   = UP_NAME   .
  WA_UPDAT-GENDER = UP_GENDER .
  WA_UPDAT-DEGREE = UP_DEGREE .
  WA_UPDAT-FIELD  = UP_FIELD  .
  WA_UPDAT-SESS   = UP_SESS   .
  WA_UPDAT-ADDRESS    = UP_ADDRESS.
  UPDATE YDB_INFO FROM WA_UPDAT.

  CLEAR: UP_ROLL,
         UP_NAME,
         UP_GENDER,
         UP_DEGREE,
         UP_FIELD,
         UP_SESS ,
         UP_ADDRESS.


MESSAGE 'SUCCESSFUL UPDATED' TYPE 'S'.

LEAVE TO SCREEN 1001.
ENDIF.

ENDMODULE.
