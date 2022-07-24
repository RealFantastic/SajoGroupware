package com.group.mayo.work.domain;

import java.sql.Date;

public class Comment {
//	COMMENT_NO   NOT NULL NUMBER        
//	C_WRITER     NOT NULL VARCHAR2(30)  
//	C_CONTENT    NOT NULL VARCHAR2(200) 
//	C_WRITE_DATE NOT NULL TIMESTAMP(6)  
//	WORK_NO      NOT NULL NUMBER 
	
	private int comment_no;
	private String c_writer;
	private String c_content;
	private Date c_write_date;
	private int work_no;
	
	private String emp_name;
	
	@Override
	public String toString() {
		return "Comment [comment_no=" + comment_no + ", c_writer=" + c_writer + ", c_content=" + c_content
				+ ", c_write_date=" + c_write_date + ", work_no=" + work_no + ", emp_name=" + emp_name + "]";
	}
	
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public int getComment_no() {
		return comment_no;
	}
	public String getC_writer() {
		return c_writer;
	}
	public String getC_content() {
		return c_content;
	}
	public Date getC_write_date() {
		return c_write_date;
	}
	public int getWork_no() {
		return work_no;
	}
	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}
	public void setC_writer(String c_writer) {
		this.c_writer = c_writer;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public void setC_write_date(Date c_write_date) {
		this.c_write_date = c_write_date;
	}
	public void setWork_no(int work_no) {
		this.work_no = work_no;
	}
	
	
}
