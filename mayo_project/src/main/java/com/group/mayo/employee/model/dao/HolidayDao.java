package com.group.mayo.employee.model.dao;

import java.util.List;
import java.util.Map;

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

//	해당연도 총 연차발생 개수
	public List<Holiday> holidayMystatus(Map<String, String> paramMap){
		return sqlSession.selectList("Holiday.holidayMystatus",paramMap);
	}

	//	개인 연차내역 리스트
	public int selectTotalHoliday(Map<String, String> paramMap) {
		return sqlSession.selectOne("Holiday.selectTotalHoliday", paramMap);
	}

	//	인사팀 - 직원 검색하기 -연차용
	public List<CommuteEmployee>holidayEmpSearch(CommuteEmployee empCommuteSearch) throws Exception{
		return sqlSession.selectList("Holiday.holidayEmpSearch", empCommuteSearch);
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
	
	public int updateEmpHd(Holiday holiday) {
		return sqlSession.update("EmpHoliday.updateEmpHd", holiday);
	}
}
