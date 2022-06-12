




DROP TABLE EA_FORM;
DROP TABLE PROJ;
DROP TABLE PROJECT_PIC;
DROP TABLE ATTENDEES;
DROP TABLE SCHEDULE;
DROP TABLE WORK_PIC;
DROP TABLE WORK_COMMENT;
DROP TABLE PROJECT_FILE;
DROP TABLE WORK_BOARD;
DROP TABLE APPROVAL_FILE;
DROP TABLE ELEC_APPROVAL;
DROP TABLE ALERT;
DROP TABLE CHAT_RECORD;
DROP TABLE CHATTING_ROOM;
DROP TABLE CHATROOM_JOIN;
DROP TABLE EMPLOYEE_HOLIDAY;
DROP TABLE HOLIDAY_HISTORY;
DROP TABLE COMMUTE_RECORD;
DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE COMPANY;
DROP TABLE WORK_TYPE;
DROP TABLE JOB;

CREATE TABLE EMPLOYEE (
	EMP_NO	VARCHAR2(50)		NOT NULL,
	EMP_NAME	VARCHAR2(30)		NOT NULL,
	PASSWORD	VARCHAR2(512)		NOT NULL,
	EMAIL	VARCHAR2(200)		NOT NULL,
	PHONE	VARCHAR2(20)		NOT NULL,
	ADDRESS	VARCHAR2(200)		NOT NULL,
	DETAIL_ADDRESS	VARCHAR2(100)		NOT NULL,
	EMP_POSTCODE	VARCHAR2(25)		NOT NULL,
	RRN	VARCHAR2(20)		NULL,
	HIRE_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	PIC_PATH	VARCHAR2(500)		NULL,
	PIC_NAME	VARCHAR2(500)		NULL,
	IS_LEAVE	VARCHAR2(3)	DEFAULT 'N'	NOT NULL,
	DEPT_NO	NUMBER		NULL,
	JOB_NO	NUMBER		NOT NULL,
	CP_NUMBER	VARCHAR2(30)		NOT NULL,
	SIGN_PATH	VARCHAR2(500)		NULL,
	SIGN_FILE_NAME	VARCHAR2(100)		NULL,
	WT_CODE	NUMBER	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN EMPLOYEE.EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';

COMMENT ON COLUMN EMPLOYEE.PASSWORD IS '암호화';

COMMENT ON COLUMN EMPLOYEE.PIC_PATH IS 'DEFAULT:선인장경로';

COMMENT ON COLUMN EMPLOYEE.PIC_NAME IS 'DEFAULT: 선인장이름';

COMMENT ON COLUMN EMPLOYEE.IS_LEAVE IS 'DEFAULT:N';

COMMENT ON COLUMN EMPLOYEE.DEPT_NO2 IS '10단위';

COMMENT ON COLUMN EMPLOYEE.JOB_NO IS '한자리수 1 ++';

COMMENT ON COLUMN EMPLOYEE.CP_NUMBER IS '사업자번호';

COMMENT ON COLUMN EMPLOYEE.WT_CODE IS '1 = 유연근무제';


CREATE TABLE JOB (
	JOB_NO	NUMBER		NOT NULL,
	JOB_NAME	VARCHAR2(30)		NOT NULL
);

COMMENT ON COLUMN JOB.JOB_NO IS '한자리수 1 ++';


CREATE TABLE DEPARTMENT (
	DEPT_NO	NUMBER		NOT NULL,
	DEPT_NAME	VARCHAR2(30)		NOT NULL
);

COMMENT ON COLUMN DEPARTMENT.DEPT_NO IS '10단위';

CREATE TABLE COMMUTE_RECORD (
	RECORD_NO	NUMBER		NOT NULL,
	EMP_NO	VARCHAR2(50)		NOT NULL,
	START_TIME	TIMESTAMP	DEFAULT SYSTIMESTAMP	NULL,
	END_TIME	TIMESTAMP	DEFAULT SYSTIMESTAMP	NULL
);

COMMENT ON COLUMN COMMUTE_RECORD.RECORD_NO IS 'NVL(MAX(NO),0)+1';

COMMENT ON COLUMN COMMUTE_RECORD.EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';


CREATE TABLE EMPLOYEE_HOLIDAY (
	EMP_NO	VARCHAR2(50)		NOT NULL,
	TOTAL	NUMBER	DEFAULT 15	NULL,
	USED_COUNT	NUMBER		NULL,
	LEFT_COUNT	NUMBER		NULL
);

COMMENT ON COLUMN EMPLOYEE_HOLIDAY.EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';

COMMENT ON COLUMN EMPLOYEE_HOLIDAY.TOTAL IS '기본 15';





CREATE TABLE COMPANY (
	CP_NUMBER	VARCHAR2(30)		NOT NULL,
	CP_NAME	VARCHAR2(100)		NOT NULL,
	CP_CATEGORY	VARCHAR2(50)		NULL,
	CP_ADDRESS	VARCHAR2(200)		NULL,
	CP_DETAIL_ADDRESS	VARCHAR2(100)		NULL,
	CP_POSTCODE	VARCHAR2(25)		NULL,
	CP_KING	VARCHAR2(30)		NOT NULL,
	CP_TEL	VARCHAR2(30)		NOT NULL,
	CP_BIRTH	VARCHAR2(30)		NULL
);

COMMENT ON COLUMN COMPANY.CP_NUMBER IS '사업자번호';

COMMENT ON COLUMN COMPANY.CP_NAME IS '회사명';

COMMENT ON COLUMN COMPANY.CP_CATEGORY IS '업종';

COMMENT ON COLUMN COMPANY.CP_ADDRESS IS '회사주소';

COMMENT ON COLUMN COMPANY.CP_DETAIL_ADDRESS IS '회사 상세주소';

COMMENT ON COLUMN COMPANY.CP_POSTCODE IS '우편번호';

COMMENT ON COLUMN COMPANY.CP_BIRTH IS '회사창립일';

CREATE TABLE WORK_TYPE (
	WT_CODE	NUMBER		NOT NULL,
	MIN_WORK_TIME	NUMBER		NULL,
	MAX_WORK_TIME	NUMBER		NULL,
	WORK_TYPE_NAME	VARCHAR2(20)		NULL
);

COMMENT ON COLUMN WORK_TYPE.MIN_WORK_TIME IS '40';

COMMENT ON COLUMN WORK_TYPE.MAX_WORK_TIME IS '40';

COMMENT ON COLUMN WORK_TYPE.WORK_TYPE_NAME IS '유연근무제';


CREATE TABLE CHATROOM_JOIN (
	JOIN_ID	NUMBER		NOT NULL,
	EMP_NO	VARCHAR2(50)		NOT NULL,
	ROOM_NO	NUMBER		NOT NULL
);

COMMENT ON COLUMN CHATROOM_JOIN.JOIN_ID IS 'SEQ_CHAT_JOIN';

COMMENT ON COLUMN CHATROOM_JOIN.EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';

COMMENT ON COLUMN CHATROOM_JOIN.ROOM_NO IS 'SEQ_CHAT_ROOM';


CREATE TABLE CHATTING_ROOM (
	ROOM_NO	NUMBER		NOT NULL,
	ROOM_NAME	VARCHAR2(30)		NULL,
	ROOM_CREATE_DATE	TIMESTAMP	DEFAULT SYSTIMESTAMP	NULL
);

COMMENT ON COLUMN CHATTING_ROOM.ROOM_NO IS 'SEQ_CHAT_ROOM';

COMMENT ON COLUMN CHATTING_ROOM.ROOM_NAME IS '기본 : 참가자1 + 참가자2+참가자3';

CREATE TABLE CHAT_RECORD (
	CHAT_NO	NUMBER		NOT NULL,
	CHAT_MESSAGE	VARCHAR2(500)		NULL,
	CHAT_TIME	TIMESTAMP	DEFAULT SYSTIMESTAMP	NULL,
	EMP_NO	VARCHAR2(50)		NOT NULL,
	JOIN_ID	NUMBER		NOT NULL
);

COMMENT ON COLUMN CHAT_RECORD.CHAT_NO IS 'SEQ_CHAT_REC';

COMMENT ON COLUMN CHAT_RECORD.EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';

COMMENT ON COLUMN CHAT_RECORD.JOIN_ID IS 'SEQ_CHAT_JOIN';


CREATE TABLE ALERT (
	ALERT_NO	NUMBER		NOT NULL,
	ALERT_CONTENT	VARCHAR2(50)		NULL,
	ALERT_DATE	TIMESTAMP	DEFAULT SYSTIMESTAMP	NULL,
	ALERT_CONTENT_ID	VARCHAR2(50)		NULL,
	TARGET_EMP_NO	VARCHAR2(50)		NOT NULL,
	EMP_NO	VARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN ALERT.ALERT_NO IS 'NVL(MAX(NO),0)+1';

COMMENT ON COLUMN ALERT.ALERT_CONTENT_ID IS '알림이 발생한 글번호';

COMMENT ON COLUMN ALERT.TARGET_EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';

COMMENT ON COLUMN ALERT.EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';



CREATE TABLE ELEC_APPROVAL (
	EA_NO	VARCHAR2(50)		NOT NULL,
	EA_TITLE	VARCHAR2(100)		NOT NULL,
	EA_CONTENT	VARCHAR2(1000)		NOT NULL,
	DRAFTER_ID	VARCHAR2(50)		NOT NULL,
	DRAFT_DATE	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	FIRST_APPROVER	VARCHAR2(50)		NULL,
	SECOND_APPROVER	VARCHAR2(50)		NULL,
	THIRD_APPROVER	VARCHAR2(50)		NULL,
	FINAL_APPROVER	VARCHAR2(50)		NULL,
	STATUS_CODE	NUMBER	DEFAULT 1	NULL,
	RESULT_CODE	VARCHAR2(1)		NULL,
	FORM_CODE	VARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN ELEC_APPROVAL.EA_NO IS '연도 + 결재양식 + 번호';

COMMENT ON COLUMN ELEC_APPROVAL.STATUS_CODE IS '0:회수,1:접수,2:진행,3:완료';

COMMENT ON COLUMN ELEC_APPROVAL.RESULT_CODE IS 'A:승인 R: 반려';

COMMENT ON COLUMN ELEC_APPROVAL.FORM_CODE IS 'BP:업무기안  SR:지출결의서  AR: 휴가신청서';


CREATE TABLE APPROVAL_FILE (
	F_NO	NUMBER		NOT NULL,
	DOC_NO	VARCHAR2(50)		NOT NULL,
	F_ORIGINAL_NAME	VARCHAR2(100)		NULL,
	F_UPLOAD_NAME	VARCHAR2(100)		NULL,
	F_PATH	VARCHAR2(500)		NULL
);

COMMENT ON COLUMN APPROVAL_FILE.F_NO IS 'NVL(MAX(NO),0)+1';


CREATE TABLE EA_FORM (
	FORM_CODE	VARCHAR2(20)		NOT NULL,
	FORM_TITLE	VARCHAR2(500)		NULL,
	FORM_CONTENT	VARCHAR2(1000)		NULL
);

COMMENT ON COLUMN EA_FORM.FORM_CODE IS 'BP:업무기안  SR:지출결의서  AR: 휴가신청서';



CREATE TABLE WORK_BOARD (
	WORK_NO	NUMBER		NOT NULL,
	PROJ_NO	NUMBER		NOT NULL,
	WORK_TITLE	VARCHAR2(50)		NULL,
	WORK_CONTENT	VARCHAR2(3000)		NULL,
	WORK_MGR	VARCHAR2(30)		NULL,
	WORK_START_DATE	DATE	DEFAULT SYSDATE	NULL,
	WORK_DEADLINE	DATE	DEFAULT SYSDATE	NULL,
	WORK_PROGRESS	NUMBER		NULL,
	ISEMERGENCY	VARCHAR2(3)	DEFAULT 'N'	NOT NULL,
	WORK_STATUS	NUMBER		NULL,
	WORK_DATE	TIMESTAMP	DEFAULT SYSTIMESTAMP	NULL
);

COMMENT ON COLUMN WORK_BOARD.WORK_NO IS 'NVL(MAX(NO),0)+1';

COMMENT ON COLUMN WORK_BOARD.PROJ_NO IS 'SEQ_PRJ_NO';

COMMENT ON COLUMN WORK_BOARD.WORK_PROGRESS IS '10%단위 설정 가능 / 최대 100 / 100= 완료';

COMMENT ON COLUMN WORK_BOARD.ISEMERGENCY IS 'Y/N';

COMMENT ON COLUMN WORK_BOARD.WORK_STATUS IS '0:요청 1:진행, 2: 완료, 3: 보류';


CREATE TABLE PROJECT_FILE (
	FILE_NO	NUMBER		NOT NULL,
	PROJ_FILE_PATH	VARCHAR2(300)		NULL,
	PROJ_FILENAME	VARCHAR2(200)		NULL,
	PROJ_ORIGINAL_FILENAME	VARCHAR2(200)		NULL,
	WORK_NO	NUMBER		NOT NULL
);

COMMENT ON COLUMN PROJECT_FILE.FILE_NO IS 'NVL(MAX(NO),0)+1';

COMMENT ON COLUMN PROJECT_FILE.WORK_NO IS 'NVL(MAX(NO),0)+1';



CREATE TABLE WORK_COMMENT (
	COMMENT_NO	NUMBER		NOT NULL,
	C_WRITER	VARCHAR2(30)		NOT NULL,
	C_CONTENT	VARCHAR2(200)		NOT NULL,
	C_WRITE_DATE	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	WORK_NO	NUMBER		NOT NULL
);

COMMENT ON COLUMN WORK_COMMENT.COMMENT_NO IS 'NVL(MAX(NO),0)+1';

COMMENT ON COLUMN WORK_COMMENT.WORK_NO IS 'NVL(MAX(NO),0)+1';



CREATE TABLE WORK_PIC (
	WORK_NO	NUMBER		NOT NULL,
	WORK_PIC_ID	VARCHAR2(50)		NULL
);

COMMENT ON COLUMN WORK_PIC.WORK_NO IS 'NVL(MAX(NO),0)+1';



CREATE TABLE SCHEDULE (
	SKED_NO	NUMBER		NOT NULL,
	SKED_NAME	VARCHAR2(50)		NOT NULL,
	SKED_DATE	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	SKED_CONTENT	VARCHAR2(1500)		NULL,
	SKED_START_DATE	DATE	DEFAULT SYSDATE	NULL,
	SKED_END_DATE	DATE	DEFAULT SYSDATE	NULL,
	SKED_LOCATION	VARCHAR2(500)		NULL,
	SKED_CATEGORY	VARCHAR2(50)		NULL,
	SKED_EMP_ID	VARCHAR2(50)		NULL
);

COMMENT ON COLUMN SCHEDULE.SKED_NO IS 'NVL(MAX(NO),0)+1';



CREATE TABLE ATTENDEES (
	SCHEDULE_NO	NUMBER		NOT NULL,
	EMP_NO	VARCHAR2(50)		NOT NULL,
	ATTENDANCE	VARCHAR2(3)		NULL
);

COMMENT ON COLUMN ATTENDEES.SCHEDULE_NO IS 'NVL(MAX(NO),0)+1';

COMMENT ON COLUMN ATTENDEES.EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';

COMMENT ON COLUMN ATTENDEES.ATTENDANCE IS 'Y/N';




CREATE TABLE PROJ (
	PROJ_NO	NUMBER		NOT NULL,
	PROJ_NAME	VARCHAR2(50)		NOT NULL,
	PROJ_DATE	TIMESTAMP		NOT NULL,
	PROJ_CONTENT	VARCHAR2(3000)		NOT NULL,
	PROJ_MGR	VARCHAR2(30)		NOT NULL,
	PROJ_TYPE	NUMBER	DEFAULT 0	NOT NULL
);

COMMENT ON COLUMN PROJ.PROJ_NO IS 'SEQ_PRJ_NO';

COMMENT ON COLUMN PROJ.PROJ_DATE IS 'SYSTIMESTAMP';

COMMENT ON COLUMN PROJ.PROJ_TYPE IS '0:기타 1:업무, 2:동호회 3:정보공유';



CREATE TABLE PROJECT_PIC (
	EMP_NO	VARCHAR2(50)		NOT NULL,
	PROJ_NO	NUMBER		NOT NULL
);

COMMENT ON COLUMN PROJECT_PIC.EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';

COMMENT ON COLUMN PROJECT_PIC.PROJ_NO IS 'SEQ_PRJ_NO';



CREATE TABLE HOLIDAY_HISTORY (
	HD_NO	NUMBER		NOT NULL,
	EMP_NO	VARCHAR2(50)		NOT NULL,
	REQ_DATE	TIMESTAMP	DEFAULT SYSTIMESTAMP	NULL,
	HD_START	DATE		NULL,
	HD_END	DATE		NULL,
	HD_CODE	VARCHAR2(1)		NULL,
	HD_COUNT	NUMBER		NULL,
	HD_RESON	VARCHAR2(100)		NULL
);

COMMENT ON COLUMN HOLIDAY_HISTORY.HD_NO IS 'NVL(MAX(NO),0)+1';

COMMENT ON COLUMN HOLIDAY_HISTORY.EMP_NO IS '년도 4자리 + 부서번호2자리 + 번호3자리';

COMMENT ON COLUMN HOLIDAY_HISTORY.HD_CODE IS 'F:연차 H: 반차';

COMMENT ON COLUMN HOLIDAY_HISTORY.HD_COUNT IS '시작일~종료일까지의 일수';

COMMENT ON COLUMN HOLIDAY_HISTORY.HD_RESON IS '연차신청사유';


ALTER TABLE EMPLOYEE ADD CONSTRAINT PK_EMP PRIMARY KEY (
	EMP_NO
);

ALTER TABLE COMPANY ADD CONSTRAINT PK_COMPANY PRIMARY KEY (
	CP_NUMBER
);

ALTER TABLE DEPARTMENT ADD CONSTRAINT PK_DEPARTMENT PRIMARY KEY (
	DEPT_NO
);

ALTER TABLE JOB ADD CONSTRAINT PK_JOB PRIMARY KEY (
	JOB_NO
);

ALTER TABLE PROJ ADD CONSTRAINT PK_PROJ PRIMARY KEY (
	PROJ_NO
);

ALTER TABLE COMMUTE_RECORD ADD CONSTRAINT PK_COMMUTE_RECORD PRIMARY KEY (
	RECORD_NO
);

ALTER TABLE SCHEDULE ADD CONSTRAINT PK_SCHEDULE PRIMARY KEY (
	SKED_NO
);

ALTER TABLE HOLIDAY_HISTORY ADD CONSTRAINT PK_HOLIDAY_HISTORY PRIMARY KEY (
	HD_NO
);

ALTER TABLE WORK_COMMENT ADD CONSTRAINT PK_WORK_COMMENT PRIMARY KEY (
	COMMENT_NO
);

ALTER TABLE PROJECT_FILE ADD CONSTRAINT PK_PROJ_FILE PRIMARY KEY (
	FILE_NO
);

ALTER TABLE ELEC_APPROVAL ADD CONSTRAINT PK_ELEC_APPROVAL PRIMARY KEY (
	EA_NO
);

ALTER TABLE APPROVAL_FILE ADD CONSTRAINT PK_APRVL_FILE PRIMARY KEY (
	F_NO
);

ALTER TABLE WORK_BOARD ADD CONSTRAINT PK_WORK_BOARD PRIMARY KEY (
	WORK_NO
);

ALTER TABLE WORK_TYPE ADD CONSTRAINT PK_WORK_TYPE PRIMARY KEY (
	WT_CODE
);

ALTER TABLE EA_FORM ADD CONSTRAINT PK_EA_FORM PRIMARY KEY (
	FORM_CODE
);

ALTER TABLE ALERT ADD CONSTRAINT PK_ALERT PRIMARY KEY (
	ALERT_NO
);

ALTER TABLE CHAT_RECORD ADD CONSTRAINT PK_CHAT_RECORD PRIMARY KEY (
	CHAT_NO
);

ALTER TABLE CHATTING_ROOM ADD CONSTRAINT PK_CHATTING_ROOM PRIMARY KEY (
	ROOM_NO
);

ALTER TABLE CHATROOM_JOIN ADD CONSTRAINT PK_CHATROOM_JOIN PRIMARY KEY (
	JOIN_ID
);

ALTER TABLE EMPLOYEE_HOLIDAY ADD CONSTRAINT PK_EMP_HOLIDAY PRIMARY KEY (
	EMP_NO
);

ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_DEPT_TO_EMP FOREIGN KEY (
	DEPT_NO2
)
REFERENCES DEPARTMENT (
	DEPT_NO
);

ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_JOB_TO_EMP FOREIGN KEY (
	JOB_NO
)
REFERENCES JOB (
	JOB_NO
);

--ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_COMPANY_TO_EMP FOREIGN KEY (
--	CP_NUMBER
--)
--REFERENCES COMPANY (
--	CP_NUMBER
--);

ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_WORK_TYPE_TO_EMP FOREIGN KEY (
	WT_CODE
)
REFERENCES WORK_TYPE (
	WT_CODE
);

ALTER TABLE COMMUTE_RECORD ADD CONSTRAINT FK_EMP_TO_COMMUTE_REC FOREIGN KEY (
	EMP_NO
)
REFERENCES EMPLOYEE (
	EMP_NO
);

ALTER TABLE HOLIDAY_HISTORY ADD CONSTRAINT FK_EMP_TO_HOLIDAY_HISTORY FOREIGN KEY (
	EMP_NO
)
REFERENCES EMPLOYEE (
	EMP_NO
);

ALTER TABLE PROJECT_PIC ADD CONSTRAINT FK_EMP_TO_PROJ_PIC FOREIGN KEY (
	EMP_NO
)
REFERENCES EMPLOYEE (
	EMP_NO
);

ALTER TABLE PROJECT_PIC ADD CONSTRAINT FK_PROJ_TO_PROJ_PIC FOREIGN KEY (
	PROJ_NO
)
REFERENCES PROJ (
	PROJ_NO
);

ALTER TABLE ATTENDEES ADD CONSTRAINT FK_SCHEDULE_TO_ATTENDEES FOREIGN KEY (
	SCHEDULE_NO
)
REFERENCES SCHEDULE (
	SKED_NO
);

ALTER TABLE ATTENDEES ADD CONSTRAINT FK_EMP_TO_ATTENDEES FOREIGN KEY (
	EMP_NO
)
REFERENCES EMPLOYEE (
	EMP_NO
);

ALTER TABLE WORK_COMMENT ADD CONSTRAINT FK_WORK_BOARD_TO_WORK_COMMENT FOREIGN KEY (
	WORK_NO
)
REFERENCES WORK_BOARD (
	WORK_NO
);

ALTER TABLE PROJECT_FILE ADD CONSTRAINT FK_WORK_BOARD_TO_PROJ_FILE FOREIGN KEY (
	WORK_NO
)
REFERENCES WORK_BOARD (
	WORK_NO
);

ALTER TABLE ELEC_APPROVAL ADD CONSTRAINT FK_EA_FORM_TO_ELEC_APPROVAL FOREIGN KEY (
	FORM_CODE
)
REFERENCES EA_FORM (
	FORM_CODE
);

ALTER TABLE APPROVAL_FILE ADD CONSTRAINT FK_ELEC_APRVL_TO_APRVL_FILE FOREIGN KEY (
	DOC_NO
)
REFERENCES ELEC_APPROVAL (
	EA_NO
);

ALTER TABLE WORK_BOARD ADD CONSTRAINT FK_PROJ_TO_WORK_BOARD FOREIGN KEY (
	PROJ_NO
)
REFERENCES PROJ (
	PROJ_NO
);

ALTER TABLE WORK_PIC ADD CONSTRAINT FK_WORK_BOARD_TO_WORK_PIC FOREIGN KEY (
	WORK_NO
)
REFERENCES WORK_BOARD (
	WORK_NO
);

ALTER TABLE ALERT ADD CONSTRAINT FK_EMP_TO_ALERT FOREIGN KEY (
	TARGET_EMP_NO
)
REFERENCES EMPLOYEE (
	EMP_NO
);

ALTER TABLE ALERT ADD CONSTRAINT FK_EMP_TO_ALERT_1 FOREIGN KEY (
	EMP_NO
)
REFERENCES EMPLOYEE (
	EMP_NO
);

ALTER TABLE CHAT_RECORD ADD CONSTRAINT FK_EMP_TO_CHAT_REC FOREIGN KEY (
	EMP_NO
)
REFERENCES EMPLOYEE (
	EMP_NO
);

ALTER TABLE CHAT_RECORD ADD CONSTRAINT FK_CHATROOM_JOIN_TO_CHAT_REC FOREIGN KEY (
	JOIN_ID
)
REFERENCES CHATROOM_JOIN (
	JOIN_ID
);

ALTER TABLE CHATROOM_JOIN ADD CONSTRAINT FK_EMP_TO_CHATROOM_JOIN FOREIGN KEY (
	EMP_NO
)
REFERENCES EMPLOYEE (
	EMP_NO
);

ALTER TABLE CHATROOM_JOIN ADD CONSTRAINT FK_CHAT_ROOM_TO_CHATROOM_JOIN FOREIGN KEY (
	ROOM_NO
)
REFERENCES CHATTING_ROOM (
	ROOM_NO
);

ALTER TABLE EMPLOYEE_HOLIDAY ADD CONSTRAINT FK_EMP_TO_EMP_HOLIDAY FOREIGN KEY (
	EMP_NO
)
REFERENCES EMPLOYEE (
	EMP_NO
);

ALTER TABLE EMPLOYEE MODIFY CP_NUMBER VARCHAR2(30);
ALTER TABLE COMPANY MODIFY CP_NUMBER VARCHAR2(30);


ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_DEPT_NO FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT (DEPT_NO);

COMMIT;



