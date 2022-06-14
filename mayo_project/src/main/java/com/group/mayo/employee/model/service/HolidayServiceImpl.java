package com.group.mayo.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.domain.HolidayEmployee;
import com.group.mayo.employee.model.dao.HolidayDao;

@Service
public class HolidayServiceImpl implements HolidayService{
	
	@Autowired
	private HolidayDao dao;
	
	@Override
	public List<HolidayEmployee> holidayEmpList(){
		return dao.holidayEmpList();
	}

}
