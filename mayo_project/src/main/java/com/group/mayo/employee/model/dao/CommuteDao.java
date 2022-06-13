package com.group.mayo.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.employee.domain.CommuteRecord;

@Repository
public class CommuteDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	public List<CommuteRecord>selectMyCommute(){
		return sqlSession.selectList("CommuteRecord.selectMyCommute");
	}
}
