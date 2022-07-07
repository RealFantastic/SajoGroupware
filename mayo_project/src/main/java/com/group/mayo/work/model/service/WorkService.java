package com.group.mayo.work.model.service;

import java.util.List;

import com.group.mayo.work.domain.Work;

public interface WorkService {

	/**
	 * @return 전체 업무 리스트
	 * @author HyerinK
	 */
	public List<Work> selectAllWork();
	
	/**
	 * @return 전체 업무 글 개수 
	 */
	public int selectTotalCnt();

	/**
	 * @param proj_no 프로젝트 번호
	 * @return 해당 프로젝트 업무 글 개수
	 */
	public int selectCnt(String proj_no);
	/**
	 * @param proj_no 프로젝트 번호
	 * @return 해당 프로젝트 업무들
	 */
	public List<Work> selectWork(String proj_no);
	
	/**
	 * @param work_no 업무번호
	 * @return 업무 글 상세
	 */
	public Work viewWork(int work_no);
	
	/**
	 * @param work 업무 글 내용들
	 * @return 생성된 업무 글 개수
	 */
	public int insertWork(Work work);
	
	/**
	 * @param work 업무 글 수정 내용
	 * @return 수정된 업무 글 개수
	 */
	public int updateWork(Work work);
	
	/**
	 * @param work_no 업무번호
	 * @return 삭제된 업무 글 개수
	 */
	public int deleteWork(String work_no);
	
}
