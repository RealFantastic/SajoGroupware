package com.group.mayo.employee.model.service;

import java.util.List;

import com.group.mayo.employee.domain.Employee;

public interface EmpService {
	
	/**
	 * 
	 * @return List Employee(회원목록)
	 * @author JHPark
	 */
	public List<Employee> selectListEmp();

}
