package com.group.mayo.employee.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;


@Component
public class Employee {
//	---------------- -------- ------------- 
//	--EMP_NO         NOT NULL VARCHAR2(50)  
//	--EMP_NAME       NOT NULL VARCHAR2(30)  
//	--PASSWORD       NOT NULL VARCHAR2(512) 
//	--EMAIL          NOT NULL VARCHAR2(200) 
//	--PHONE          NOT NULL VARCHAR2(20)  
//	--ADDRESS        NOT NULL VARCHAR2(200) 
//	--DETAIL_ADDRESS NOT NULL VARCHAR2(100) 
//	--EMP_POSTCODE   NOT NULL VARCHAR2(25)  
//	--RRN                     VARCHAR2(20)  
//	--HIRE_DATE      NOT NULL DATE          
//	--PIC_PATH                VARCHAR2(500) 
//	--PIC_NAME                VARCHAR2(500) 
//	--IS_LEAVE       NOT NULL VARCHAR2(3)   
//	--DEPT_NO               NUMBER        
//	--JOB_NO         NOT NULL NUMBER        
//	--CP_NUMBER      NOT NULL NUMBER        
//	--SIGN_PATH               VARCHAR2(500) 
//	--SIGN_FILE_NAME          VARCHAR2(100) 
//	--WT_CODE        NOT NULL NUMBER
	private String emp_no;
	private String emp_name;
	private String password;
	private String email;
	private String phone;
	private String address;
	private String detail_address;
	private String emp_postcode;
	private String rrn;
	private Date hire_date;
	private String pic_path;
	private String pic_name;
	private String is_leave;
	private int dept_no;
	private int job_no;
	private String cp_number;
	private String sign_path;
	private String sign_file_name;
	private String wt_code;
	
	private String dept_name;
	private String job_name;
	
	
	
	
	
	
	

	@Override
	public String toString() {
		return "Employee [emp_no=" + emp_no + ", emp_name=" + emp_name + ", password=" + password + ", email=" + email
				+ ", phone=" + phone + ", address=" + address + ", detail_address=" + detail_address + ", emp_postcode="
				+ emp_postcode + ", rrn=" + rrn + ", hire_date=" + hire_date + ", pic_path=" + pic_path + ", pic_name="
				+ pic_name + ", is_leave=" + is_leave + ", dept_no=" + dept_no + ", job_no=" + job_no + ", cp_number="
				+ cp_number + ", sign_path=" + sign_path + ", sign_file_name=" + sign_file_name + ", wt_code=" + wt_code
				+ ", dept_name=" + dept_name + ", job_name=" + job_name + "]";
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	public String getEmp_postcode() {
		return emp_postcode;
	}
	public void setEmp_postcode(String emp_postcode) {
		this.emp_postcode = emp_postcode;
	}
	public String getRrn() {
		return rrn;
	}
	public void setRrn(String rrn) {
		this.rrn = rrn;
	}
	public Date getHire_date() {
		return hire_date;
	}
	public void setHire_date(Date hire_date) {
		this.hire_date = hire_date;
	}
	public String getPic_path() {
		return pic_path;
	}
	public void setPic_path(String pic_path) {
		this.pic_path = pic_path;
	}
	public String getPic_name() {
		return pic_name;
	}
	public void setPic_name(String pic_name) {
		this.pic_name = pic_name;
	}
	public String getIs_leave() {
		return is_leave;
	}
	public void setIs_leave(String is_leave) {
		this.is_leave = is_leave;
	}
	public int getDept_no() {
		return dept_no;
	}
	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}
	public int getJob_no() {
		return job_no;
	}
	public void setJob_no(int job_no) {
		this.job_no = job_no;
	}
	public String getCp_number() {
		return cp_number;
	}
	public void setCp_number(String cp_number) {
		this.cp_number = cp_number;
	}
	public String getSign_path() {
		return sign_path;
	}
	public void setSign_path(String sign_path) {
		this.sign_path = sign_path;
	}
	public String getSign_file_name() {
		return sign_file_name;
	}
	public void setSign_file_name(String sign_file_name) {
		this.sign_file_name = sign_file_name;
	}
	public String getWt_code() {
		return wt_code;
	}
	public void setWt_code(String wt_code) {
		this.wt_code = wt_code;
	}
	
	
	
	
	
	
	
	
	
}
