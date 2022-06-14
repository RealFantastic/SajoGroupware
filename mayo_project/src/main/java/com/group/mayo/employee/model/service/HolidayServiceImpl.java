package com.group.mayo.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.model.dao.HolidayDao;

@Service
public class HolidayServiceImpl {
	
	@Autowired
	private HolidayDao dao;
	
	
	public List<Holiday> holidayEmpList(){
		return dao.holidayEmpList();
	}
}
