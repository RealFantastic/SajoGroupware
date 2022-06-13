package com.group.mayo.department.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.department.domain.Dept;

@Repository
public class DeptDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<Dept> selectDeptList() {
		
		return sqlSession.selectList("Dept.selectDeptList");
	}
}
