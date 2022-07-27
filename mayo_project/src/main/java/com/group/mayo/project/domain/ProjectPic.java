package com.group.mayo.project.domain;

import java.util.Arrays;

import org.springframework.stereotype.Component;

@Component
public class ProjectPic {
	
//	EMP_NO  NOT NULL VARCHAR2(50) 
//	PROJ_NO NOT NULL NUMBER     
	
	private String emp_no;
	private int proj_no;
	private String emp_name;
	private String job_name;

	@Override
	public String toString() {
		return "ProjectPic [emp_no=" + emp_no + ", proj_no=" + proj_no + ", emp_name=" + emp_name + ", job_name="
				+ job_name + ", emp_no_arr=" + Arrays.toString(emp_no_arr) + "]";
	}

	public String getJob_name() {
		return job_name;
	}

	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	private String[] emp_no_arr;
	
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public int getProj_no() {
		return proj_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public void setProj_no(int proj_no) {
		this.proj_no = proj_no;
	}
	public String[] getEmp_no_arr() {
		return emp_no_arr;
	}
	public void setEmp_no_arr(String[] emp_no_arr) {
		this.emp_no_arr = emp_no_arr;
	}
	
	
	
}
