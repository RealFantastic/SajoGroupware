package com.group.mayo.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.model.dao.EmpDao;

@Service
@Transactional
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
	
	@Override
	public Employee selectLogin(Employee employee) {
		return dao.selectLogin(employee);		
	}
	
	//아이디 중복 확인
	@Override
	public int checkEmpNo(String emp_no) {
		int result = dao.checkEmpNo(emp_no);
		return result;
	}
	//주민번호 중복 확인
	@Override
	public int checkRrn(String rrn) {
		int result = dao.checkRrn(rrn);
		return result;
	}
	//사업자 번호 중복 확인
	@Override
	public int checkCpNumber(String cp_number) {
		int result = dao.checkCpNumber(cp_number);
		return result;
	}
	// 아이디 찾기
	@Override
	public Employee findId(Employee employee) {
		return dao.findId(employee) ;
	}
	// 비밀번호 찾기
	@Override
	public Employee findPwd(Employee employee) {
		return dao.findPwd(employee) ;
	}
	// 비밀번호 재설정
	@Override
	public Employee updatePwd(Employee employee) {
		return dao.updatePwd(employee) ;
	}
	
}
