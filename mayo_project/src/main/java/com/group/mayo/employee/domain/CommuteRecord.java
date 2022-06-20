package com.group.mayo.employee.domain;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

@Component
public class CommuteRecord {
//이름         널?       유형           
//---------- -------- ------------ 
//RECORD_NO  NOT NULL NUMBER		기록번호      
//EMP_NO     NOT NULL VARCHAR2(50)	사원번호(아이디)
//START_TIME          TIMESTAMP(6)	시작시간
//END_TIME            TIMESTAMP(6)	종료시간

	private int record_no;
	private String emp_no;
	private String today_start_time;
	private String today_end_time;
	
	private Timestamp start_time;
	private Timestamp end_time;
		

	
	
	@Override
	public String toString() {
		return "CommuteRecord [record_no=" + record_no + ", emp_no=" + emp_no + ", today_start_time=" + today_start_time
				+ ", today_end_time=" + today_end_time + ", start_time=" + start_time + ", end_time=" + end_time + "]";
	}
	public int getRecord_no() {
		return record_no;
	}
	public void setRecord_no(int record_no) {
		this.record_no = record_no;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public Timestamp getStart_time() {
		return start_time;
	}
	public void setStart_time(Timestamp start_time) {
		this.start_time = start_time;
	}
	public Timestamp getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Timestamp end_time) {
		this.end_time = end_time;
	}
	public String getToday_start_time() {
		return today_start_time;
	}
	public void setToday_start_time(String today_start_time) {
		this.today_start_time = today_start_time;
	}
	public String getToday_end_time() {
		return today_end_time;
	}
	public void setToday_end_time(String today_end_time) {
		this.today_end_time = today_end_time;
	}

	
}
