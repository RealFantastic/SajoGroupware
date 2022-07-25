package com.group.mayo.project.model.service;

import java.util.List;

import com.group.mayo.employee.domain.Employee;
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
	 * @author HyerinK
	 */
	public int insertProj(Project proj);
	
	/**
	 * @param proj_no, proj 프로젝트 번호, 수정 내용
	 * @return 수정된 프로젝트 개수
	 * @author HyerinK
	 */
	public int updateProj(Project proj);
	
	/**
	 * @param proj_no 프로젝트 번호
	 * @return 삭제된 프로젝트 개수
	 * @author HyerinK
	 */
	public int deleteProj(String proj_no);
	
	/**
	 * @param proj 프로젝트 번호 proj_no
	 * @return 프로젝트 정보
	 * @author HyerinK
	 */
	public Project selectProj(String proj_no);
	
	/**
	 * @param emp 직원 정보
	 * @return 추가된 직원 수 
	 * @author HyerinK
	 */
	public int insertPic(Employee emp);
	
	/**
	 * @param emp_no 사원번호
	 * @return 삭제된 직원 수
	 * @author HyerinK
	 */
	public int deletePic(String emp_no);
	
}
