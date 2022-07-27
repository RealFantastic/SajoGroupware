package com.group.mayo.project.domain;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

@Component
public class Project {

//	PROJ_NO      NOT NULL NUMBER         
//	PROJ_NAME    NOT NULL VARCHAR2(50)   
//	PROJ_DATE    NOT NULL TIMESTAMP(6)   
//	PROJ_CONTENT NOT NULL VARCHAR2(3000) 
//	PROJ_MGR     NOT NULL VARCHAR2(30)   
//	PROJ_TYPE    NOT NULL NUMBER        0:기타, 1:업무, 2:동호회, 3:정보공유
	
	private int proj_no;
	private String proj_name;
	private Timestamp proj_date;
	private String proj_content;
	private String proj_mgr;
	private int proj_type;
	private String emp_name;
	private String job_name;
	private String emp_no;
	

	@Override
	public String toString() {
		return "Project [proj_no=" + proj_no + ", proj_name=" + proj_name + ", proj_date=" + proj_date
				+ ", proj_content=" + proj_content + ", proj_mgr=" + proj_mgr + ", proj_type=" + proj_type
				+ ", emp_name=" + emp_name + ", job_name=" + job_name + ", emp_no=" + emp_no + "]";
	}

	public String getJob_name() {
		return job_name;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}

	public String getEmp_name() {
		return emp_name;
	}
	
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	
	public int getProj_no() {
		return proj_no;
	}
	public String getProj_name() {
		return proj_name;
	}
	public Timestamp getProj_date() {
		return proj_date;
	}
	public String getProj_content() {
		return proj_content;
	}
	public String getProj_mgr() {
		return proj_mgr;
	}
	public int getProj_type() {
		return proj_type;
	}
	public void setProj_no(int proj_no) {
		this.proj_no = proj_no;
	}
	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}
	public void setProj_date(Timestamp proj_date) {
		this.proj_date = proj_date;
	}
	public void setProj_content(String proj_content) {
		this.proj_content = proj_content;
	}
	public void setProj_mgr(String proj_mgr) {
		this.proj_mgr = proj_mgr;
	}
	public void setProj_type(int proj_type) {
		this.proj_type = proj_type;
	}
	
	
	
}
