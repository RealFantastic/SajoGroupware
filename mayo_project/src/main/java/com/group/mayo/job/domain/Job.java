package com.group.mayo.job.domain;

import org.springframework.stereotype.Component;

@Component
public class Job {
//	-------- -------- ------------ 
//	JOB_NO   NOT NULL NUMBER       
//	JOB_NAME NOT NULL VARCHAR2(30) 
	private int job_no;
	private String job_name;
	public int getJob_no() {
		return job_no;
	}
	public void setJob_no(int job_no) {
		this.job_no = job_no;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	@Override
	public String toString() {
		return "Job [job_no=" + job_no + ", job_name=" + job_name + "]";
	}
	
	
	
	
}
