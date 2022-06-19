package com.group.mayo.employee.model.service;

import java.sql.Date;
import java.util.List;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;

public interface CommuteService {

	/**
	 * @return 리턴할 값 입력해주기 /TODO 각 사원별 출근시간 , 퇴근시간
	 * @author hong
	 */
	public List<CommuteRecord> myCommuteStatus() ;
	
	/**
	 * @return 출근시간
	 * 
	 * @author hong
	 */
	public CommuteRecord statusAtt(String id);
	
//	public CommuteRecord selectStatusAtt();
	
	
	/**
	 * @return 사원번호, 사원명, 직함, 부서명, 연락처
	 * @author hong
	 */
	public List<CommuteEmployee>empCommuteList();
	
	
	
	/**
	 * @return 근무일, 출근시간, 퇴근시간
	 * @author hong
	 */
	public List<CommuteRecord>empCommuteChange();

	
	
}
