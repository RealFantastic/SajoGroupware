package com.group.mayo.company.domain;

import java.util.List;

import org.springframework.stereotype.Component;

import com.group.mayo.department.domain.Dept;
import com.group.mayo.employee.domain.Employee;

@Component
public class Company {
//	CP_NUMBER         NOT NULL VARCHAR2(30)  
//	CP_NAME           NOT NULL VARCHAR2(100) 
//	CP_CATEGORY                VARCHAR2(50)  
//	CP_ADDRESS                 VARCHAR2(200) 
//	CP_DETAIL_ADDRESS          VARCHAR2(100) 
//	CP_POSTCODE                VARCHAR2(25)  
//	CP_KING           NOT NULL VARCHAR2(30)  
//	CP_TEL            NOT NULL VARCHAR2(30)  
//	CP_BIRTH                   VARCHAR2(30) 
	
	private String cp_number;
	private String cp_name;
	private String cp_category;
	private String cp_address;
	private String cp_detail_address;
	private String cp_postcode;
	private String cp_king;
	private String cp_tel;
	private String cp_birth;
	
	private List<Dept> deptlist;
	private List<Employee> emplist;
	

	@Override
	public String toString() {
		return "Company [cp_number=" + cp_number + ", cp_name=" + cp_name + ", cp_category=" + cp_category
				+ ", cp_address=" + cp_address + ", cp_detail_address=" + cp_detail_address + ", cp_postcode="
				+ cp_postcode + ", cp_king=" + cp_king + ", cp_tel=" + cp_tel + ", cp_birth=" + cp_birth + ", deptlist="
				+ deptlist + ", emplist=" + emplist + "]";
	}
	public List<Dept> getDeptlist() {
		return deptlist;
	}
	public void setDeptlist(List<Dept> deptlist) {
		this.deptlist = deptlist;
	}
	public List<Employee> getEmplist() {
		return emplist;
	}
	public void setEmplist(List<Employee> emplist) {
		this.emplist = emplist;
	}
	public String getCp_number() {
		return cp_number;
	}
	public void setCp_number(String cp_number) {
		this.cp_number = cp_number;
	}
	public String getCp_name() {
		return cp_name;
	}
	public void setCp_name(String cp_name) {
		this.cp_name = cp_name;
	}
	public String getCp_category() {
		return cp_category;
	}
	public void setCp_category(String cp_category) {
		this.cp_category = cp_category;
	}
	public String getCp_address() {
		return cp_address;
	}
	public void setCp_address(String cp_address) {
		this.cp_address = cp_address;
	}
	public String getCp_detail_address() {
		return cp_detail_address;
	}
	public void setCp_detail_address(String cp_detail_address) {
		this.cp_detail_address = cp_detail_address;
	}
	public String getCp_postcode() {
		return cp_postcode;
	}
	public void setCp_postcode(String cp_postcode) {
		this.cp_postcode = cp_postcode;
	}
	public String getCp_king() {
		return cp_king;
	}
	public void setCp_king(String cp_king) {
		this.cp_king = cp_king;
	}
	public String getCp_tel() {
		return cp_tel;
	}
	public void setCp_tel(String cp_tel) {
		this.cp_tel = cp_tel;
	}
	public String getCp_birth() {
		return cp_birth;
	}
	public void setCp_birth(String cp_birth) {
		this.cp_birth = cp_birth;
	}
	
	
	
}
