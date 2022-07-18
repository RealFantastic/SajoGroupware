package com.group.mayo.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.domain.HolidayEmployee;

@Repository
public class HolidayDao {
	
	@Autowired
	private SqlSession sqlSession;
	
//	페이지 띄우기
	public List<HolidayEmployee> holidayEmpList() {
		return sqlSession.selectList("Holiday.holidayEmpList");
	}
	
	//	개인정보
	public CommuteEmployee commuteMyInfo(String id) {
		return sqlSession.selectOne("CommuteRecord.commuteMyInfo", id);
	}

	//개인 연차내역 리스트
	public List<Holiday> holidayMystatus;


	//	인사팀 - 직원 검색하기
	public List<CommuteEmployee>commuteEmpSearch(CommuteEmployee empCommuteSearch) throws Exception{
		return sqlSession.selectList("CommuteRecord.commuteEmpSearch", empCommuteSearch);
	}
	
	public int insertHoliday(Holiday holiday) {
		return sqlSession.insert("Holiday.insertHoliday", holiday);
	}
	
	public Holiday selectHoliday(String ea_no) {
		return sqlSession.selectOne("Holiday.selectHoliday", ea_no);
	}
	
	public int deleteHoliday(String ea_no) {
		return sqlSession.delete("Holiday.deleteHoliday",ea_no);
	}
}
