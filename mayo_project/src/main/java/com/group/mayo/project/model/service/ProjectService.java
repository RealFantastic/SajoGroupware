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
	 * @param 새로운 프로젝트 - 종류(proj_type), 제목(proj_name), 내용(proj_content), 생성자(proj_mgr)
	 * @return 추가된 프로젝트 개수 
	 */
	public int insertProj(Project proj);
	
	
	/**
	 * 
	 * @param proj 프로젝트 번호 proj_no
	 * @return 삭제된 프로젝트 개수
	 */
	public int deleteProj(int proj_no);
	
}
