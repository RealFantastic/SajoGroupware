package com.group.mayo.approval.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.group.mayo.approval.domain.EapDomain;

@Repository
public class EapDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int insertEap(EapDomain eap) {
		return sqlSession.insert("Eap.insertEap", eap);
	}
}
