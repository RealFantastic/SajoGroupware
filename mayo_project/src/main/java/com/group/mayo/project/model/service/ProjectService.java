package com.group.mayo.project.model.service;

import java.util.List;

import com.group.mayo.project.domain.Project;

public interface ProjectService {
	
	/**
	 * @return 전체 프로젝트 리스트
	 * @author HyerinK
	 */
	public List<Project> selectAllProj();
	
	/**
	 * @param 새로운 프로젝트 - 종류, 제목, 내용
	 * @return 추가된 프로젝트 개수 
	 */
	public int insertProj(Project proj);
}
