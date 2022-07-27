package com.group.mayo.employee.domain;

public class CommuteEmployee {

	private String emp_no;
	private String emp_name;
	private String phone;
	private String dept_nm;
	private String job_nm;
	
//	검색기능
	private String search_type; //검색타입 - 직원번호,이름,부서
	private String search_keyword; //검색어 입력
	
	//연차검색기능
	private String left_count; //전체직원 연차리스트에서 검색할 경우 잔여연차

	@Override
	public String toString() {
		return "CommuteEmployee [emp_no=" + emp_no + ", emp_name=" + emp_name + ", phone=" + phone + ", dept_nm="
				+ dept_nm + ", job_nm=" + job_nm + ", search_type=" + search_type + ", search_keyword=" + search_keyword
				+ ", left_count=" + left_count + "]";
	}
	
	
	public String getLeft_count() {
		return left_count;
	}
	public void setLeft_count(String left_count) {
		this.left_count = left_count;
	}


	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}


	public String getSearch_keyword() {
		return search_keyword;
	}
	public void setSearch_keyword(String search_keyword) {
		this.search_keyword = search_keyword;
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
