package com.group.mayo.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.company.domain.Company;
import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.model.dao.EmpDao;

@Service
//@Transactional
public class EmpServiceImpl implements EmpService{
	@Autowired
	private EmpDao dao;
	
	public List<Employee> selectListEmp() {
		return dao.selectListEmp();
	}

	@Override
	public Employee selectEmployee(String emp_no) {
		return dao.selectEmployee(emp_no);
	}
	
	//직원등록
	@Override
	public int insertEmployee(Employee employee) {
		return dao.insertEmployee(employee);
	}
	public Employee selectLogin(Employee employee) {
		return dao.selectLogin(employee);		
	}
	
}
