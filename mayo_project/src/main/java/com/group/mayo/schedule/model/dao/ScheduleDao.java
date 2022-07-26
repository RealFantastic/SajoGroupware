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
	public List<Schedule> selectAllSked(String emp_no){
		return sqlSession.selectList("Schedule.selectAllSked", emp_no);
	}
	
	// 특정 프로젝트 전체 일정 조회
	public List<Schedule> selectSked(String sked_category){
		return sqlSession.selectList("Schedule.selectSked", sked_category);
	}
	
	// 전사 일정 조회
	public List<Schedule> selectSkedA(){
		return sqlSession.selectList("Schedule.selectSkedA");
	}
	
	// 개인 일정 조회
	public List<Schedule> selectSkedP(String emp_no){
		return sqlSession.selectList("Schedule.selectSkedP", emp_no);
	}
	
	// 특정 일정 조회
	public Schedule viewSked(String sked_no) {
		return sqlSession.selectOne("Schedule.viewSked", sked_no);
	}
	
	// 특정 일정 삭제
	public int deleteSked(String sked_no) {
		return sqlSession.delete("Schedule.deleteSked", sked_no);
	}
	
	// 특정 일정 수정
	public int updateSked(Schedule sked) {
		return sqlSession.update("Schedule.updateSked", sked);
	}
}
