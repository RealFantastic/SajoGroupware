package com.group.mayo.schedule.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.schedule.domain.Schedule;
import com.group.mayo.schedule.model.dao.ScheduleDao;

@Service
@Transactional
public class ScheduleServiceImpl implements ScheduleService{

	@Autowired
	private ScheduleDao dao;
	
	@Override
	public int insertSked(Schedule sked) {
		return dao.insertSked(sked);
	}

	@Override
	public List<Schedule> selectAllSked() {
		return dao.selectAllSked();
	}

	@Override
	public List<Schedule> selectSked(String sked_category) {
		return dao.selectSked(sked_category);
	}

	@Override
	public Schedule viewSked(String sked_no) {
		return dao.viewSked(sked_no);
	}

	@Override
	public int deleteSked(String sked_no) {
		return dao.deleteSked(sked_no);
	}
}
