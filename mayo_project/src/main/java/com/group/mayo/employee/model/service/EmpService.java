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
	
	/**
	 * @author JHpark
	 * @param emp_no : 사원 번호
	 * @return
	 */
	public Employee selectEmployee(String emp_no);	
	/**
	 * 
	 * @return 추가된 직원수
	 * @author XeonSnee
	 */
	public int insertEmployee(Employee employee);
	/**
	 * 
	 * @return 로그인한 직원 정보
	 * @author XeonSnee
	 */
	public Employee selectLogin(Employee employee);
	/**
	 * 
	 * @return 아이디(사원번호) 중복확인
	 * @author XeonSnee
	 */
	public int checkEmpNo(String emp_no);
	/**
	 * 
	 * @return 주민번호 중복확인
	 * @author XeonSnee
	 */
	public int checkRrn(String rrn);
	/**
	 * 
	 * @return 사업자 번호 중복확인
	 * @author XeonSnee
	 */
	public int checkCpNumber(String cp_number);
	/**
	 * 
	 * @return 아이디 찾기시 정보가 일치하는 직원 수 
	 * @author XeonSnee
	 */
	public Employee findId(Employee employee);
}
