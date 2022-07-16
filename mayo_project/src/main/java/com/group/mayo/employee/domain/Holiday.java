package com.group.mayo.employee.domain;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.stereotype.Component;

@Component
public class Holiday {
//이름       널?       유형            
//-------- -------- ------------- 
//HD_NO    NOT NULL NUMBER        
//EMP_NO   NOT NULL VARCHAR2(50)  
//REQ_DATE          TIMESTAMP(6)  
//HD_START          DATE          
//HD_END            DATE          
//HD_CODE           VARCHAR2(1)   
//HD_COUNT          NUMBER        
//HD_RESON          VARCHAR2(100)
//EA_NO				VARCHAR2(50)

	private int hd_no;
	private String emp_no;
	private	Timestamp req_date;
	private	Date hd_start;
	private	Date hd_end;
	private	String hd_code;
	private	int hd_count;
	private	String hd_reson;
	private String ea_no;
	
	
	@Override
	public String toString() {
		return "Holiday [hd_no=" + hd_no + ", emp_no=" + emp_no + ", req_date=" + req_date + ", hd_start=" + hd_start
				+ ", hd_end=" + hd_end + ", hd_code=" + hd_code + ", hd_count=" + hd_count + ", hd_reson=" + hd_reson
				+ ", ea_no=" + ea_no + "]";
	}
	
	public int getHd_no() {
		return hd_no;
	}
	public void setHd_no(int hd_no) {
		this.hd_no = hd_no;
	}


	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}


	public Timestamp getReq_date() {
		return req_date;
	}
	public void setReq_date(Timestamp req_date) {
		this.req_date = req_date;
	}


	public Date getHd_start() {
		return hd_start;
	}
	public void setHd_start(Date hd_start) {
		this.hd_start = hd_start;
	}


	public Date getHd_end() {
		return hd_end;
	}
	public void setHd_end(Date hd_end) {
		this.hd_end = hd_end;
	}


	public String getHd_code() {
		return hd_code;
	}
	public void setHd_code(String hd_code) {
		this.hd_code = hd_code;
	}


	public int getHd_count() {
		return hd_count;
	}
	public void setHd_count(int hd_count) {
		this.hd_count = hd_count;
	}


	public String getHd_reson() {
		return hd_reson;
	}
	public void setHd_reson(String hd_reson) {
		this.hd_reson = hd_reson;
	}

	public String getEa_no() {
		return ea_no;
	}

	public void setEa_no(String ea_no) {
		this.ea_no = ea_no;
	}
	
	
}
