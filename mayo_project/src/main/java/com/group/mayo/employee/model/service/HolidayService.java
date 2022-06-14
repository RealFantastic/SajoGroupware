package com.group.mayo.employee.model.service;

import java.util.List;

import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.domain.HolidayEmployee;

public interface HolidayService {

	/**
	 * @return 사원번호, 사원명, 직함, 부서명, 연락처, 잔여연차
	 * @author hong
	 */
	public List<HolidayEmployee>holidayEmpList();
}
