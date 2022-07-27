package com.group.mayo.approval.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.eaform.domain.EaForm;
import com.group.mayo.employee.domain.Employee;

@Repository
public class EapDao {
	@Autowired
	private SqlSession sqlSession;
	
	public String selectNewEaNo(EapDomain eap) {
		return sqlSession.selectOne("Eap.selectNewEaNo",eap);
	}
	
	public int insertEap(EapDomain eap) {
		return sqlSession.insert("Eap.insertEap", eap);
	}
	
	public List<EaForm> selectListEaForm() {
		return sqlSession.selectList("EaForm.selectListEaForm");
	}
	
	public EaForm selectForm(String form_code) {
		return sqlSession.selectOne("EaForm.selectForm",form_code);
	}
	public double selectLoginUserHoliday(String emp_no) {
		return sqlSession.selectOne("Eap.selectLoginUserHoliday",emp_no);
	}
	
	public List<EapDomain> selectMyList(Employee employee) {
		return sqlSession.selectList("Eap.selectMyList", employee);
	}
	public EapDomain selectDraft(EapDomain eap) {
		return sqlSession.selectOne("Eap.selectDraft",eap);
	}
	public EapDomain selectResult(EapDomain eap) {
		return sqlSession.selectOne("Eap.selectResult",eap);
	}
	public int deleteEap(String ea_no) {
		return sqlSession.delete("Eap.deleteEap", ea_no);
	}
	public List<EapDomain> selectListWaitApprove(String emp_no) {
		return sqlSession.selectList("Eap.selectListWaitApprove", emp_no);
	}
	public EapDomain selectWait(EapDomain eap) {
		return sqlSession.selectOne("Eap.selectDraft",eap);
	}
	public int updateAppr(EapDomain eap) {
		return sqlSession.update("Eap.updateAppr",eap);
	}
	public int updateReject(EapDomain eap) {
		return sqlSession.update("Eap.updateReject",eap);
	}
	public List<EapDomain> selectMyListProceeding(Employee employee) {
		return sqlSession.selectList("Eap.selectMyListProceeding",employee);
	}
	public List<EapDomain> selectMyListComplete(Employee employee) {
		return sqlSession.selectList("Eap.selectMyListComplete",employee);
	}
}
