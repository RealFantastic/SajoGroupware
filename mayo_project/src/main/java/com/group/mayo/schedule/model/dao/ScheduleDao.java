package com.group.mayo.schedule.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.schedule.domain.Schedule;

@Repository
public class ScheduleDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int insertSked(Schedule sked) {
		return sqlSession.insert("Schedule.insertSked", sked);
	}
}
