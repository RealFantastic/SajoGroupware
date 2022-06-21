package com.group.mayo.approval.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.eaform.domain.EaForm;

@Repository
public class EapDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int insertEap(EapDomain eap) {
		return sqlSession.insert("Eap.insertEap", eap);
	}
	
	public List<EaForm> selectListEaForm() {
		return sqlSession.selectList("EaForm.selectListEaForm");
	}
	
	public EaForm selectForm(String form_code) {
		return sqlSession.selectOne("EaForm.selectForm",form_code);
	}
}
