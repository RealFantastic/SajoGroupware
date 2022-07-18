package com.group.mayo.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.domain.HolidayEmployee;
import com.group.mayo.employee.model.dao.HolidayDao;

@Service
public class HolidayServiceImpl implements HolidayService{
	
	@Autowired
	private HolidayDao dao;
	
//	페이지 띄우기
	@Override
	public List<HolidayEmployee> holidayEmpList(){
		return dao.holidayEmpList();
	}
	
//	개인정보
	@Override
	public CommuteEmployee commuteMyInfo(String id) {
		return dao.commuteMyInfo(id);
	}

//	개인 연차내역 리스트
	@Override
	public List<Holiday> holidayMystatus() {
		return dao.holidayMystatus;
	}


	
//	인사팀 직원조회
	@Override
	public List<CommuteEmployee> commuteEmpSearch(CommuteEmployee empCommuteSearch) throws Exception {
		return dao.commuteEmpSearch(empCommuteSearch);
	}
	
	
	@Override
	public int insertHoliday(Holiday holiday) {
		return dao.insertHoliday(holiday);
	}

	@Override
	public Holiday selectHoliday(String ea_no) {
		
		return dao.selectHoliday(ea_no);
	}
	
}
