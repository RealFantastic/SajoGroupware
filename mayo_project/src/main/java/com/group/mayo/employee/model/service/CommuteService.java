package com.group.mayo.employee.model.service;

import java.util.List;
import java.util.Map;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;

public interface CommuteService {

//template_left
	/**
	 * @return 리턴할 값 : 로그인한 사원 오늘 출근시간, 퇴근시간
	 * @author hong
	 */
	public CommuteRecord myCommuteStatus(String id ) ;

	/**
	 * @return 출근시간
	 * @author hong
	 */
	public CommuteRecord statusAtt(String id);

	/**
	 * @return 퇴근시간
	 * @author hong
	 */
	public CommuteRecord statusLeave(String id);




//	개인근태페이지
	//	그래프
	/**
	 *@param paramMap
	 *@return 주근무시간, 주남은근무시간
	 *@author hong
	 */
	public CommuteRecord chartData(Map<String, String> paramMap);
	
	
	//	개인정보
	/**
	 * @return 사원번호, 사원명, 직함, 부서명, 연락처
	 * @author hong 
	 */
	public CommuteEmployee commuteMyInfo(String id);

	//	개인근태내역
	/**
	 * @param paramMap
	 * @return 근무일, 출근시간, 퇴근시간, 일근무시간, 주근무시간, 주남은근무시간
	 * @author hong
	 */
	public List<CommuteRecord> commuteMystatus(Map<String, String> paramMap);
	




//	인사팀 - 직원근태내역 리스트
	/**
	 * @return 사원번호, 사원명, 직함, 부서명, 연락처
	 * @author hong
	 */
	public List<CommuteEmployee>empCommuteList();



//	인사팀 - 직원개인정보
	/**
	 * @return 검색결과 : 사원번호, 사원명, 직함, 부서명, 연락처
	 * @author hong
	 */
	public List<CommuteEmployee> commuteEmpSearch(CommuteEmployee empCommuteSearch) throws Exception;




//	인사팀 - 직원근태 상세 - 수정
	/**
	 * @return 근무일, 출근시간, 퇴근시간
	 * @author hong
	 */
	public List<CommuteRecord>empCommuteChange();






}
