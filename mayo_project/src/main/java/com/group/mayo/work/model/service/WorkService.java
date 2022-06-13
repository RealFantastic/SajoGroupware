package com.group.mayo.work.model.service;

import java.util.List;

import com.group.mayo.work.domain.Work;

public interface WorkService {

	/**
	 * @return 전체 업무 리스트
	 * @author HyerinK
	 */
	public List<Work> selectAllWork();
}
