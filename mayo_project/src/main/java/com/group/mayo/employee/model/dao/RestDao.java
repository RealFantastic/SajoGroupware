package com.group.mayo.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.employee.domain.Rest;

@Repository
public class RestDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<Rest> restEmpList() {
		return sqlSession.selectList("Rest.restEmpList");
	}
}
