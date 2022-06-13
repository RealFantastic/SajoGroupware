package com.group.mayo.project.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.project.domain.Project;
import com.group.mayo.project.model.dao.ProjectDao;

@Service
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
	
	
	
}
