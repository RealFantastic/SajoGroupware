package com.group.mayo.department.domain;

import java.util.List;

import org.springframework.stereotype.Component;

import com.group.mayo.employee.domain.Employee;

@Component
public class Dept {
//	이름        널?       유형           
//			--------- -------- ------------ 
//			DEPT_NO   NOT NULL NUMBER       
//			DEPT_NAME NOT NULL VARCHAR2(30)
	private int dept_no;
	private String dept_name;
	
	private List<Employee> emplist;
	
	
	
	
	
	
	
	

	@Override
	public String toString() {
		return "Dept [dept_no=" + dept_no + ", dept_name=" + dept_name + ", emplist=" + emplist + "]";
	}
	
	
	public List<Employee> getEmplist() {
		return emplist;
	}
	public void setEmplist(List<Employee> emplist) {
		this.emplist = emplist;
	}
	public int getDept_no() {
		return dept_no;
	}
	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	
	
	
}
