package com.group.mayo.holidayEmp.service;

import com.group.mayo.employee.domain.HolidayEmployee;

public interface EmpHolidayService {
	/**
	 * 
	 * @return 1년차 사원 연차
	 * @author XeonSnee
	 */
	public int insertTotal(HolidayEmployee hemployee);
	
	/**
	 * 
	 * @param hemployee
	 * @return 0 or 1
	 * @author JHPark
	 */
	public int updateEmpHd(HolidayEmployee hemployee);
}
