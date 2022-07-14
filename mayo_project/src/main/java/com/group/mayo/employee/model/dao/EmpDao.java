package com.group.mayo.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.employee.domain.Employee;

@Repository
public class EmpDao {
	@Autowired
	SqlSession sqlSession;
	
	public List<Employee> selectListEmp() {
		return sqlSession.selectList("Employee.selectListEmp");
	}
	
	public Employee selectEmployee(String emp_no) {
		return sqlSession.selectOne("Employee.selectMember",emp_no);
	}
		//직원등록
	public int insertEmployee(Employee employee) {
		return sqlSession.insert("Employee.insertEmployee",employee);
	}
	public Employee selectLogin(Employee employee) {
		return sqlSession.selectOne("Employee.selectLogin", employee);
	}
	// 아이디 중복 확인
	public int checkEmpNo(String emp_no) {
		int result = sqlSession.selectOne("Employee.checkEmpNo",emp_no);
		System.out.println("안녕");
		
		return result;
	}
	// 주민번호 중복 확인
	public int checkRrn(String rrn) {
		int result = sqlSession.selectOne("Employee.checkRrn",rrn);
		System.out.println("안녕");
		
		return result;
	}
	//사업자 번호 중복 확인
	public int checkCpNumber(String cp_number) {
		int result = sqlSession.selectOne("Employee.checkCpNumber",cp_number);
		System.out.println("살려주세여!!");
		
		return result;
	}

}
