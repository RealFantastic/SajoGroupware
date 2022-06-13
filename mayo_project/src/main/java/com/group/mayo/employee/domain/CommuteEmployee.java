package com.group.mayo.employee.domain;

public class CommuteEmployee {

	private String emp_no;
	private String emp_name;
	private String phone;
	private String dept_nm;
	private String job_nm;
	@Override
	public String toString() {
		return "CommuteEmployee [emp_no=" + emp_no + ", emp_name=" + emp_name + ", phone=" + phone + ", dept_nm="
				+ dept_nm + ", job_nm=" + job_nm + "]";
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
}
