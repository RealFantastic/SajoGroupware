package com.group.mayo.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;
import com.group.mayo.employee.model.dao.CommuteDao;

@Service
public class CommuteServiceImpl implements CommuteService{

	@Autowired
	private CommuteDao dao;
	
	//개인근태페이지
	@Override
	public CommuteRecord myCommuteStatus(String id) {
		return dao.myCommuteStatus(id);
	}
	
	//출근시간
	@Override
	public CommuteRecord statusAtt(String id) {
		
		int result = dao.statusAtt();
		CommuteRecord attTime= null;
		if(result !=0)
			return dao.selectStatusAtt(id);

		return attTime;
	}
	//퇴근시간
	@Override
	public CommuteRecord statusLeave(String id) {
		int result =dao.statusLeave();
		CommuteRecord leaveTime=null;
		if(result !=0)
			return dao.selectStatusLeave(id);
		
		return leaveTime;
	}
	
	@Override
	public CommuteEmployee commuteMyInfo() {
		return dao.commuteMyInfo();
}
	


	@Override
	public List<CommuteEmployee> empCommuteList() {
		
		return dao.empCommuteList();
	}
	
	@Override
	public List<CommuteRecord> empCommuteChange() {
		return dao.empCommuteChange();
	}


}
