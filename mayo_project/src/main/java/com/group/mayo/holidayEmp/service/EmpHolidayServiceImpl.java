package com.group.mayo.holidayEmp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.employee.domain.HolidayEmployee;
import com.group.mayo.holidayEmp.dao.EmpHolidayDao;

@Service
public class EmpHolidayServiceImpl implements EmpHolidayService{
	@Autowired
	private EmpHolidayDao dao;
	
	@Override
	public int insertTotal(HolidayEmployee hemployee) {
		return dao.insertTotal(hemployee);
	}

	@Override
	public int updateEmpHd(HolidayEmployee hemployee) {
		return dao.updateEmpHd(hemployee);
	}
	
	
	
}
