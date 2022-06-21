package com.group.mayo.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.company.domain.Company;
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
}
