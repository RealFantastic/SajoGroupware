package com.group.mayo.schedule.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.schedule.domain.Schedule;

@Repository
public class ScheduleDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 일정 등록
	public int insertSked(Schedule sked) {
		return sqlSession.insert("Schedule.insertSked", sked);
	}
	
	// 전체 일정 조회
	public List<Schedule> selectAllSked(){
		return sqlSession.selectList("Schedule.selectAllSked");
	}
	
	// 특정 프로젝트 전체 일정 조회
	public List<Schedule> selectSked(int proj_no){
		return sqlSession.selectList("Schedule.selectSked", proj_no);
	}
	
	// 특정 일정 조회
	public Schedule viewSked(int sked_no) {
		return sqlSession.selectOne("Schedule.viewSked", sked_no);
	}
}
