package com.group.mayo.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;
import com.group.mayo.employee.domain.Employee;

@Repository
public class CommuteDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	public List<CommuteRecord>myCommuteStatus(){
		return sqlSession.selectList("CommuteRecord.myCommuteStatus");
	}
	
	public List<CommuteEmployee>empCommuteList(){
		return sqlSession.selectList("CommuteRecord.empCommuteList");
	}
	
	public List<CommuteRecord>empCommuteChange(){
		return sqlSession.selectList("CommuteRecord.empCommuteChange");
	}
}
