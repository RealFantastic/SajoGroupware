package com.group.mayo.project.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.mayo.employee.domain.Employee;
import com.group.mayo.project.domain.Project;
import com.group.mayo.project.domain.ProjectPic;
import com.group.mayo.project.model.dao.ProjectDao;

@Service
@Transactional
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	private ProjectDao dao;
	
	@Override
	public List<Project> selectAllProj(String emp_no){
		return dao.selectAllProj(emp_no);
	}

	@Override
	public int insertProj(Project proj) {
		return dao.insertProj(proj);
	}

	@Override
	public int updateProj(Project proj) {
		return dao.updateProj(proj);
	}
	
	@Override
	public int deleteProj(int proj_no) {
		return dao.deleteProj(proj_no); 
	}

	@Override
	public Project selectProj(String proj_no) {
		return dao.selectProj(proj_no);
	}

	@Override
	public int insertPic(ProjectPic emp) {
		return dao.insertPic(emp);
	}

	@Override
	public int deletePic(String emp_no) {
		return dao.deletePic(emp_no);
	}

	@Override
	public List<ProjectPic> selectPic(String proj_no) {
		return dao.selectPic(proj_no);
	}

	
}
