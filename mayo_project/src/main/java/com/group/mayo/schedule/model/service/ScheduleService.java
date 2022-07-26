package com.group.mayo.schedule.model.service;

import java.util.List;

import com.group.mayo.schedule.domain.Schedule;

public interface ScheduleService {

	/**
	 * @param sked 일정 내용
	 * @return 추가된 일정 개수
	 * @author HyerinK
	 */
	public int insertSked(Schedule sked);
	
	/**
	 * @param emp_no 로그인 한 사원 사번
	 * @return 전체 담당 프로젝트 전체 일정들
	 * @author HyerinK
	 */
	public List<Schedule> selectAllSked(String emp_no);

	/**
	 * @param proj_no
	 * @return 특정 프로젝트 전체 일정들
	 * @author HyerinK
	 */
	public List<Schedule> selectSked(String sked_category);
	
	/**
	 * @return 전사 일정
	 * @author HyerinK
	 */
	public List<Schedule> selectSkedA();
	
	/**
	 * @param emp_no 로그인 한 사원 사번
	 * @return 개인 일정
	 * @author HyerinK
	 */
	public List<Schedule> selectSkedP(String emp_no);

	/**
	 * @param sked_no
	 * @return 특정 일정 글
	 * @author HyerinK
	 */
	public Schedule viewSked(String sked_no);
	
	/**
	 * @param sked_no
	 * @return 삭제된 일정 글
	 */
	public int deleteSked(String sked_no);
	
	/**
	 * @param sked_no
	 * @return 수정된 글
	 * @author HyerinK
	 */
	public int updateSked(Schedule sked);
	
	/**
	 * @param emp_no
	 * @return List<schedule>
	 */
	public List<Schedule> selectAllminiCalPlan(String emp_no);
	
}
