package com.group.mayo.project.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.project.domain.Project;
import com.group.mayo.project.model.dao.ProjectDao;

@Service
@Transactional
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	private ProjectDao dao;
	
	@Override
	public List<Project> selectAllProj(){
		return dao.selectAllProj();
	}

	@Override
	public int insertProj(Project proj) {
		return dao.insertProj(proj);
	}

	@Override
	public int deleteProj(int proj_no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Project selectProj(int proj_no) {
		return dao.selectProj(proj_no);
	}
	
	
	
}
