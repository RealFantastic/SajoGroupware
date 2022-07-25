package com.group.mayo.employee.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.domain.HolidayEmployee;
import com.group.mayo.employee.model.dao.HolidayDao;
import com.group.mayo.holidayEmp.dao.EmpHolidayDao;

@Service
public class HolidayServiceImpl implements HolidayService{
	
	@Autowired
	private HolidayDao dao;
	
	@Autowired
	private EmpHolidayDao ehdao;
	
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
	public List<Holiday> holidayMystatus(Map<String, String> paramMap) {
		return dao.holidayMystatus(paramMap);
	}


	
//	인사팀 직원조회
	@Override
	public List<CommuteEmployee> commuteEmpSearch(CommuteEmployee empCommuteSearch) throws Exception {
		return dao.commuteEmpSearch(empCommuteSearch);
	}
	
//	해당연도 발생연차 갯수
	@Override
	public int selectTotalHoliday(Map<String, String> paramMap) {
		return dao.selectTotalHoliday(paramMap);
	}
	
	
	
	
	
	
	
	
	@Override
	public int insertHoliday(Holiday holiday) {
		return dao.insertHoliday(holiday);
	}

	@Override
	public Holiday selectHoliday(String ea_no) {
		
		return dao.selectHoliday(ea_no);
	}

	@Override
	public int deleteHoliday(String ea_no) {
		Holiday holiday = dao.selectHoliday(ea_no);
		double restoreCnt = holiday.getHd_count();
		HolidayEmployee hemployee = new HolidayEmployee();
		hemployee.setUsed_count(restoreCnt);//사용 연차 = 복구해야할 연차
		hemployee.setEmp_no(holiday.getEmp_no()); //복구할 사원 번호
		hemployee.setLeft_count(restoreCnt + hemployee.getLeft_count());// 잔여연차 = 사용연차 + 기존 잔여연차
		
		int restoreResult = ehdao.updateRestore(hemployee);
		int result = 0;
		if(restoreResult != 0) {
			result=dao.deleteHoliday(ea_no);
		}
		
		return result;
	}	
	
}
