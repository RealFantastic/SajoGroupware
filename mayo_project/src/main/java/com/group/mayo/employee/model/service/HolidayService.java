package com.group.mayo.employee.model.service;

import java.util.List;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.domain.HolidayEmployee;

public interface HolidayService {

	/**
	 * @return 일단페이지
	 * @author hong
	 */
	public List<HolidayEmployee>holidayEmpList();
	
	
	
	/**
	 * 
	 * @param id
	 * @return 사원번호, 사원명, 직함, 부서명, 연락처
	 * @author hong
	 */
	public CommuteEmployee commuteMyInfo(String id);
	
	
	
	
	/**
	 * @return 검색결과 : 사원번호, 사원명, 직함, 부서명, 연락처
	 * @author hong
	 */
	public List<CommuteEmployee> commuteEmpSearch(CommuteEmployee empCommuteSearch) throws Exception;
	
	/**
	 * 
	 * @param holiday
	 * @return 0 or 1
	 * @author JHPark
	 */
	public int insertHoliday(Holiday holiday);
}
