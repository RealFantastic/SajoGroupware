package com.group.mayo.schedule.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class Schedule {
	
//	SKED_NO         NOT NULL NUMBER          
//	SKED_NAME       NOT NULL VARCHAR2(50)    
//	SKED_DATE       NOT NULL TIMESTAMP(6)    
//	SKED_CONTENT             VARCHAR2(1500)  
//	SKED_START_DATE          DATE            
//	SKED_END_DATE            DATE            
//  SKED_LOCATION            VARCHAR2(500)   
//	SKED_CATEGORY            VARCHAR2(50)    
//	SKED_EMP_ID              VARCHAR2(50)    

	private int sked_no;
	private String sked_name;
	private Date sked_date;
	private String sked_content;
	private Date sked_start_date;
	private Date sked_end_date;
	private String sked_location;
	private String sked_category;
	private String sked_emp_id;
	
	@Override
	public String toString() {
		return "Schedule [sked_no=" + sked_no + ", sked_name=" + sked_name + ", sked_date=" + sked_date
				+ ", sked_content=" + sked_content + ", sked_start_date=" + sked_start_date + ", sked_end_date="
				+ sked_end_date + ", sked_location=" + sked_location + ", sked_category=" + sked_category
				+ ", sked_emp_id=" + sked_emp_id + "]";
	}

	public int getSked_no() {
		return sked_no;
	}

	public String getSked_name() {
		return sked_name;
	}

	public Date getSked_date() {
		return sked_date;
	}

	public String getSked_content() {
		return sked_content;
	}

	public Date getSked_start_date() {
		return sked_start_date;
	}

	public Date getSked_end_date() {
		return sked_end_date;
	}

	public String getSked_location() {
		return sked_location;
	}

	public String getSked_category() {
		return sked_category;
	}

	public String getSked_emp_id() {
		return sked_emp_id;
	}

	public void setSked_no(int sked_no) {
		this.sked_no = sked_no;
	}

	public void setSked_name(String sked_name) {
		this.sked_name = sked_name;
	}

	public void setSked_date(Date sked_date) {
		this.sked_date = sked_date;
	}

	public void setSked_content(String sked_content) {
		this.sked_content = sked_content;
	}

	public void setSked_start_date(Date sked_start_date) {
		this.sked_start_date = sked_start_date;
	}

	public void setSked_end_date(Date sked_end_date) {
		this.sked_end_date = sked_end_date;
	}

	public void setSked_location(String sked_location) {
		this.sked_location = sked_location;
	}

	public void setSked_category(String sked_category) {
		this.sked_category = sked_category;
	}

	public void setSked_emp_id(String sked_emp_id) {
		this.sked_emp_id = sked_emp_id;
	}
	
	
	
}
