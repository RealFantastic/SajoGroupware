package com.group.mayo.employee.model.dao;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;

@Repository
public class CommuteDao {

	@Autowired
	private SqlSession sqlSession;
	
//	template_left

	//	출퇴근시간 확인
	public CommuteRecord myCommuteStatus(String id){
		return sqlSession.selectOne("CommuteRecord.toDayCommuteStatus", id);
	}

	//	출근시간
	public int statusAtt(String id) {
		return sqlSession.insert("CommuteRecord.statusAtt",id);
	}
	public CommuteRecord selectStatusAtt(String id) {
		return sqlSession.selectOne("CommuteRecord.selectStatusAtt",id);
	}

	//	퇴근시간
	public int statusLeave(String id) {
		return sqlSession.update("CommuteRecord.statusLeave",id);
	}
	public CommuteRecord selectStatusLeave(String id) {
		return sqlSession.selectOne("CommuteRecord.selectStatusLeave",id);
	}




//	개인근태페이지

	//	개인정보
	public CommuteEmployee commuteMyInfo(String id) {
		return sqlSession.selectOne("CommuteRecord.commuteMyInfo", id);
	}
	
	//	개인근태내역
	public List<CommuteRecord> commuteMystatus(String id) {
		return sqlSession.selectList("CommuteRecord.commuteMystatus", id);
	}


//	인사팀 - 직원근태내역 리스트

	//	직원 전체 띄움
	public List<CommuteEmployee>empCommuteList(){
		return sqlSession.selectList("CommuteRecord.empCommuteList");
	}

	//	직원 검색하기
	public List<CommuteEmployee>commuteEmpSearch(CommuteEmployee empCommuteSearch) throws Exception{
		return sqlSession.selectList("CommuteRecord.commuteEmpSearch", empCommuteSearch);
	}




//	인사팀 - 직원근태 상세 - 수정
	public List<CommuteRecord>empCommuteChange(){
		return sqlSession.selectList("CommuteRecord.empCommuteChange");
	}

}
