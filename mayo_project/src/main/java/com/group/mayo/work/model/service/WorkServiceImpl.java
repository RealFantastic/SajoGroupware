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

	@Override
	public List<Work> selectWork(String proj_no) {
		return dao.selectWork(proj_no);
	}

	@Override
	public Work viewWork(int work_no) {
		return dao.viewWork(work_no);
	}

	@Override
	public int insertWork(Work work) {
		return dao.insertWork(work);
	}

	@Override
	public int updateWork(Work work) {
		return dao.updateWork(work);
	}

	@Override
	public int deleteWork(String work_no) {
		return dao.deleteWork(work_no);
	}
	
	
}
