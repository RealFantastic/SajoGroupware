package com.group.mayo.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.employee.domain.Holiday;

@Repository
public class HolidayDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<Holiday> holidayEmpList() {
		return sqlSession.selectList("Holiday.holidayEmpList");
	}
}
