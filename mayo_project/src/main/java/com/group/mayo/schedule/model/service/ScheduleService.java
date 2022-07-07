package com.group.mayo.schedule.model.service;

import com.group.mayo.schedule.domain.Schedule;

public interface ScheduleService {

	/**
	 * @param sked 일정 내용
	 * @return 추가된 일정 개수
	 * @author HyerinK
	 */
	public int insertSked(Schedule sked);
}
