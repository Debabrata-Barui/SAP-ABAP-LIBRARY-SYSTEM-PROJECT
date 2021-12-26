*&---------------------------------------------------------------------*
*&      Module  STATUS_1002  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1002 OUTPUT.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.

DATA: MATCH_DATA TYPE YDB_LOGIN.

IF SY-UCOMM = 'BK'.
  LEAVE TO SCREEN 1000.
ELSEIF SY-UCOMM = 'EXIT'.
  LEAVE TO SCREEN 0.
ELSEIF SY-UCOMM = 'CENCEL'.
  LEAVE TO SCREEN 0.
ENDIF.


ENDMODULE.



*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1002 INPUT.
  CLEAR: STUID, MSG.
IF SY-UCOMM = 'SUBMIT'.
 SELECT SINGLE * FROM YDB_LOGIN INTO MATCH_DATA WHERE USERID = PHONE.
 IF SY-SUBRC IS NOT INITIAL.
    IF PHONE IS NOT INITIAL AND PASS  IS NOT INITIAL AND PASS2 IS NOT INITIAL.
      IF STRLEN( PASS ) >= 8 AND STRLEN( PHONE ) = 10.
        IF PASS EQ PASS2.
          SELECT MAX( STU_ID ) INTO STUID FROM YDB_LOGIN.
            STUID = STUID + 1.
          SELECT SINGLE * FROM YDB_LOGIN INTO CORRESPONDING FIELDS OF WA_LOGIN2
           WHERE USERID = PHONE AND PASSWORD = PASS.
           IF SY-SUBRC IS NOT INITIAL.
             WA_LOGIN-MANDT = SY-UNAME.
             WA_LOGIN-STU_ID = STUID.
             WA_LOGIN-USERID = PHONE.
             WA_LOGIN-PASSWORD = PASS.
            INSERT YDB_LOGIN FROM WA_LOGIN.
            LEAVE TO SCREEN 1003.
          ENDIF.
        ELSE.
          MSG = 'PLEASE ENTER THE CURRECT PASSWORD'.
        ENDIF.
      ELSE.
         MSG = 'ENTER 10 DIGITS USER ID AND MINIMUM 8 CHARACTER PASSWORD'.
      ENDIF.
    ELSE.
      MSG = 'PLEASE ENTER THE CURRECT RECORD'.
    ENDIF.
  ELSE.
   MESSAGE 'THE USER ALREADY EXISTS' TYPE 'E'.
  ENDIF.
ENDIF.



IF SY-UCOMM = 'BACKWARD'.
  LEAVE TO SCREEN 1000.
ELSEIF SY-UCOMM = 'EXIT'.
  LEAVE TO SCREEN 0.
ELSEIF SY-UCOMM = 'CENCEL'.
  LEAVE TO SCREEN 0.
 ENDIF.

ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  STATUS_1003  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1003 OUTPUT.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.


  CLEAR: PHONE,
         NAM,
         GEN,
         DEG,
         FLD,
         SESS,
         ROL,
         ADD,
         DT2.


PHONE = WA_LOGIN-USERID.

DAT2 = SY-DATUM.

YEAR = DAT2+0(4).
MONTH = DAT2+4(2).
DAY = DAT2+6(2).
CONCATENATE DAY MONTH YEAR INTO DAT SEPARATED BY '/'.
CLEAR : YEAR, MONTH, DAY.

DATA: VRM_ID TYPE VRM_ID,
      LIST TYPE VRM_VALUES,
      VALUES LIKE LINE OF LIST.

 VRM_ID = 'SESS'.
  VALUES-KEY = '1'.
  VALUES-TEXT = '2017-2019'.
  APPEND VALUES TO LIST.
  CLEAR: VALUES.

  VALUES-KEY = '2'.
  VALUES-TEXT = '2018-2020'.
  APPEND VALUES TO LIST.
  CLEAR: VALUES.

  VALUES-KEY = '3'.
  VALUES-TEXT = '2019-2021'.
  APPEND VALUES TO LIST.
  CLEAR: VALUES.

  VALUES-KEY = '4'.
  VALUES-TEXT = '20120-2022'.
  APPEND VALUES TO LIST.
  CLEAR: VALUES.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      ID                    = VRM_ID
      VALUES                = LIST
*   EXCEPTIONS
*     ID_ILLEGAL_NAME       = 1
*     OTHERS                = 2
            .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.



ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1003  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1003 INPUT.

  CLEAR: STUID, MSG, WA_INFO.
   SELECT MAX( STU_ID ) INTO STUID FROM YDB_LOGIN.
IF SY-UCOMM = 'OK'.

IF MALE = 'X'.
  GEN = 'MALE'.
ELSEIF FEMALE = 'X'.
  GEN = 'FEMALE'.
ELSE.
  GEN = 'OTHERS'.
ENDIF.

READ TABLE LIST INTO VALUES WITH KEY KEY = SESS.

WA_INFO-MANDT            = SY-UNAME.
WA_INFO-STU_ID           = STUID.
WA_INFO-USERID           = PHONE.
WA_INFO-ROLL             = ROL.
WA_INFO-NAME             = NAM.
WA_INFO-GENDER           = GEN.
WA_INFO-DEGREE           = DEG.
WA_INFO-FIELD            = FLD.
WA_INFO-SESS             = VALUES-TEXT.
WA_INFO-ADDRESS          = ADD.
WA_INFO-DATE_AND_TIME    = DAT.
 INSERT YDB_INFO FROM WA_INFO.
CLEAR: WA_INFO,
      SY-UNAME,
      STUID,
      PHONE,
      ROL,
      NAM,
      GEN,
      DEG,
      FLD,
      VALUES-TEXT,
      ADD,
      DAT.



 IF SY-SUBRC IS INITIAL.
   LEAVE TO SCREEN 1000.
 ENDIF.
ENDIF.

REFRESH: LIST.
CLEAR: VALUES.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_1004  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
