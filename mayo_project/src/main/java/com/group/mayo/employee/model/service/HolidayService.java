package com.group.mayo.employee.model.service;

import java.util.List;
import java.util.Map;

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
	 * @param
	 * @return 신청일, 연차시작, 연차종료, 사용연차, 잔여연차, 비고
	 * @author hong
	 */
	public List<Holiday> holidayMystatus(Map<String, String> paramMap);
	


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
	
	/**
	 * 
	 * @param ea_no
	 * @return 결재문서에 작성된 휴가 신청 내용
	 * @author JHPark
	 */
	public Holiday selectHoliday(String ea_no);
	
	/**
	 * 
	 * @param ea_no
	 * @return 0 or 1
	 * @author JHPark
	 */
	public int deleteHoliday(String ea_no);
}
