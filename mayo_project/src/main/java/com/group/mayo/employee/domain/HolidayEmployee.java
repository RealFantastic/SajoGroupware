package com.group.mayo.employee.domain;

public class HolidayEmployee {

	//테이블 명 : EMPLOYEE_HOLIDAY
	private int birth_no;
	private int birth_year;
	private int total;
	private double used_count; // 사용개수  
	private double left_count; // 잔여개수
	
	
	
	
	private String emp_no;
	private String emp_name;
	private String phone;
	private String dept_nm;
	private String job_nm;
	
	
	
	
	@Override
	public String toString() {
		return "HolidayEmployee [birth_no=" + birth_no + ", birth_year=" + birth_year + ", emp_no=" + emp_no
				+ ", total=" + total + ", used_count=" + used_count + ", left_count=" + left_count + ", emp_no="
				+ emp_no + ", emp_name=" + emp_name + ", phone=" + phone + ", dept_nm=" + dept_nm + ", job_nm=" + job_nm
				+ "]";
	}
	
	
	public int getBirth_no() {
		return birth_no;
	}
	public void setBirth_no(int birth_no) {
		this.birth_no = birth_no;
	}
	
	
	public int getBirth_year() {
		return birth_year;
	}
	public void setBirth_year(int birth_year) {
		this.birth_year = birth_year;
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
	
	
	public double getUsed_count() {
		return used_count;
	}
	public void setUsed_count(double used_count) {
		this.used_count = used_count;
	}
	
	
	public double getLeft_count() {
		return left_count;
	}
	public void setLeft_count(double left_count) {
		this.left_count = left_count;
	}



}
