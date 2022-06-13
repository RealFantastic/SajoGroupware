package com.group.mayo.work.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.work.domain.Work;
import com.group.mayo.work.model.dao.WorkDao;

@Service
@Transactional
public class WorkServiceImpl implements WorkService{

	@Autowired
	private WorkDao dao;
	
	@Override
	public List<Work> selectAllWork(){
		return dao.selectAllWork();
	}
	
	
}
