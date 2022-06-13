package com.group.mayo.work.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.work.domain.Work;

@Repository
public class WorkDao {

	@Autowired
	private SqlSession sqlSession;
	
	public List<Work> selectAllWork() {
		return sqlSession.selectList("Work.selectAllWork");
	}
}
