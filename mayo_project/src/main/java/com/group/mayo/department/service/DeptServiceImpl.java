package com.group.mayo.department.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.department.dao.DeptDao;
import com.group.mayo.department.domain.Dept;

@Service
public class DeptServiceImpl implements DeptService {
	
	@Autowired
	private DeptDao dao;
	
	@Override
	public List<Dept> selectDeptList() {

		return dao.selectDeptList();
	}
	
}
