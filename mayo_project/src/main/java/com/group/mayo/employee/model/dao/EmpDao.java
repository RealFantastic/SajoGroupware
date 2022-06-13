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
	
}
