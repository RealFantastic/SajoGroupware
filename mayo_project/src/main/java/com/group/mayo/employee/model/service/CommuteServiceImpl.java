package com.group.mayo.employee.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;
import com.group.mayo.employee.model.dao.CommuteDao;

@Service
public class CommuteServiceImpl implements CommuteService{

	@Autowired
	private CommuteDao dao;

//	template_left

	//	출퇴근시간 확인
	@Override
	public CommuteRecord myCommuteStatus(String id) {
		return dao.myCommuteStatus(id);
	}

	//	출근시간
	@Override
	public CommuteRecord statusAtt(String id) {
		
		int result = dao.statusAtt(id);
		CommuteRecord attTime= null;
		if(result !=0)
			return dao.selectStatusAtt(id);
		
		return attTime;
	}

	//	퇴근시간
	@Override
	public CommuteRecord statusLeave(String id) {
		int result =dao.statusLeave(id);
		CommuteRecord leaveTime=null;
		if(result !=0)
			return dao.selectStatusLeave(id);
		
		return leaveTime;
	}



//	개인근태페이지

	//	개인정보
	@Override
	public CommuteEmployee commuteMyInfo(String id) {
		return dao.commuteMyInfo(id);
}
	//	개인근태내역
	@Override
	public List<CommuteRecord> commuteMystatus(Map<String, String> paramMap) {
		return dao.commuteMystatus(paramMap);
	}
	
	

//	인사팀 - 직원근태내역 리스트

	//	직원 전체 띄움
	@Override
	public List<CommuteEmployee> empCommuteList() {
		
		return dao.empCommuteList();
	}
	//	직원 검색하기
	@Override
	public List<CommuteEmployee> commuteEmpSearch(CommuteEmployee empCommuteSearch) throws Exception {
		return dao.commuteEmpSearch(empCommuteSearch);
	}




//	인사팀 - 직원근태 상세 - 수정
	@Override
	public List<CommuteRecord> empCommuteChange() {
		return dao.empCommuteChange();
	}


}
