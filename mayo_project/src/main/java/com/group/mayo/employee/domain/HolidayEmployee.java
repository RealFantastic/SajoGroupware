package com.group.mayo.employee.domain;

public class HolidayEmployee {

	private String emp_no;
	private String emp_name;
	private String phone;
	private String dept_nm;
	private String job_nm;
	
	//테이블 명 : EMPLOYEE_HOLIDAY
	private int total;
	private int used_count; // 사용개수  
	private int left_count; // 잔여개수
	
	
	@Override
	public String toString() {
		return "HolidayEmployee [emp_no=" + emp_no + ", emp_name=" + emp_name + ", phone=" + phone + ", dept_nm="
				+ dept_nm + ", job_nm=" + job_nm + ", total=" + total + ", used_count=" + used_count + ", left_count="
				+ left_count + "]";
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getJob_nm() {
		return job_nm;
	}
	public void setJob_nm(String job_nm) {
		this.job_nm = job_nm;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getUsed_count() {
		return used_count;
	}
	public void setUsed_count(int used_count) {
		this.used_count = used_count;
	}
	public int getLeft_count() {
		return left_count;
	}
	public void setLeft_count(int left_count) {
		this.left_count = left_count;
	}
	
	
	
}
