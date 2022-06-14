package com.group.mayo.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.employee.domain.Rest;
import com.group.mayo.employee.model.dao.RestDao;

@Service
public class RestServiceImpl {
	
	@Autowired
	private RestDao dao;
	
	
	public List<Rest> restEmpList(){
		return dao.restEmpList();
	}
}
