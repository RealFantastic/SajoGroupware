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
	
	public List<Work> selectWork(int proj_no) {
		return sqlSession.selectList("Work.selectWork", proj_no);
	}
	
	public Work viewWork(int work_no) {
		return sqlSession.selectOne("Work.viewWork", work_no);
	}
	
	public int insertWork(Work work) {
		return sqlSession.insert("Work.insertWork", work);
	}
}
