package com.group.mayo.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.model.dao.CommuteDao;

@Service
public class CommuteServiceImpl implements CommuteService{

	@Autowired
	private CommuteDao dao;
	
	@Override
	public List<CommuteRecord> myCommuteStatus() {
		return dao.myCommuteStatus();
	}
	
	@Override
	public List<CommuteEmployee> empCommuteList() {
		
		return dao.empCommuteList();
	}
	
	@Override
	public List<CommuteRecord> empCommuteChange() {
		return dao.empCommuteChange();
	}
}
