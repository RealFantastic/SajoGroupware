package com.group.mayo.department.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.department.domain.Dept;

@Repository
public class DeptDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<Map<String,Object>> selectDeptList() {
		
		return sqlSession.selectList("Dept.selectDeptList");
	}
}
